// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * Turbo Manatee (TUMA) - BEP20 / ERC20 compatible
 * - Fixed supply (mint once in constructor to deployer)
 * - No tax
 * - Owner: pause/unpause, optional blacklist (with permanent disable switch), batch airdrop
 * - Rescue ERC20 and BNB
 *
 * Compile: 0.8.24, Optimizer enabled, 200 runs
 * Chain: BSC mainnet (56) / testnet (97)
 */
contract TurboManatee {
    // ===== ERC20 Metadata =====
    string private constant _name = "Turbo Manatee";
    string private constant _symbol = "TUMA";
    uint8  private constant _decimals = 18;

    // ===== ERC20 Storage =====
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // ===== Ownership =====
    address public owner;

    // ===== Pausable =====
    bool public paused;

    // ===== Optional Blacklist =====
    // - Off by default (no one is blacklisted initially)
    // - Can be permanently disabled via disableBlacklistForever()
    mapping(address => bool) public blacklisted;
    bool public blacklistDisabled;

    // ===== Events =====
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Paused(address indexed account);
    event Unpaused(address indexed account);
    event BlacklistUpdated(address indexed account, bool isBlacklisted);
    event BlacklistDisabled();
    event Rescue(address indexed tokenOrNative, address indexed to, uint256 amount);

    // ===== Modifiers =====
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // optional check for approve-like flows
    modifier checkBlacklist(address from, address to) {
        if (!blacklistDisabled) {
            require(!blacklisted[from] && !blacklisted[to], "Blacklisted");
        }
        _;
    }

    // ===== Constructor =====
    /**
     * @param initialSupply Tokens (without decimals). e.g., pass 100_000_000 for 100M TUMA.
     * The contract will mint initialSupply * 10^18 to deployer.
     */
    constructor(uint256 initialSupply) {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);

        uint256 amount = initialSupply * (10 ** uint256(_decimals));
        _mint(msg.sender, amount);
    }

    // ===== ERC20 Standard =====
    function name() public pure returns (string memory) { return _name; }
    function symbol() public pure returns (string memory) { return _symbol; }
    function decimals() public pure returns (uint8) { return _decimals; }
    function totalSupply() public view returns (uint256) { return _totalSupply; }
    function balanceOf(address account) public view returns (uint256) { return _balances[account]; }

    function transfer(address to, uint256 value)
        public
        returns (bool)
    {
        _transfer(msg.sender, to, value);
        return true;
    }

    function allowance(address owner_, address spender) public view returns (uint256) {
        return _allowances[owner_][spender];
    }

    function approve(address spender, uint256 value)
        public
        checkBlacklist(msg.sender, spender)
        returns (bool)
    {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value)
        public
        returns (bool)
    {
        uint256 currentAllowance = _allowances[from][msg.sender];
        require(currentAllowance >= value, "ERC20: insufficient allowance");
        unchecked { _approve(from, msg.sender, currentAllowance - value); }
        _transfer(from, to, value);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        external
        checkBlacklist(msg.sender, spender)
        returns (bool)
    {
        _approve(msg.sender, spender, _allowances[msg.sender][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        external
        checkBlacklist(msg.sender, spender)
        returns (bool)
    {
        uint256 currentAllowance = _allowances[msg.sender][spender];
        require(currentAllowance >= subtractedValue, "ERC20: below zero");
        unchecked { _approve(msg.sender, spender, currentAllowance - subtractedValue); }
        return true;
    }

    // ===== Owner Controls =====

    /// Pause all transfers (safety switch). Use unpause to resume.
    function pause() external onlyOwner {
        require(!paused, "Already paused");
        paused = true;
        emit Paused(msg.sender);
    }

    function unpause() external onlyOwner {
        require(paused, "Not paused");
        paused = false;
        emit Unpaused(msg.sender);
    }

    /// Ownership management
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    /// Guard against renouncing while paused (would permanently brick transfers)
    function renounceOwnership() external onlyOwner {
        require(!paused, "Unpause before renounce");
        emit OwnershipTransferred(owner, address(0));
        owner = address(0);
    }

    /// Optional blacklist administration (if you don't intend to use it, never call these)
    function setBlacklist(address account, bool isBlacklisted) external onlyOwner {
        require(!blacklistDisabled, "Blacklist disabled");
        blacklisted[account] = isBlacklisted;
        emit BlacklistUpdated(account, isBlacklisted);
    }

    /// Permanently disable blacklist feature (irreversible)
    function disableBlacklistForever() external onlyOwner {
        require(!blacklistDisabled, "Already disabled");
        blacklistDisabled = true;
        emit BlacklistDisabled();
    }

    /// Batch airdrop from owner balance
    /// @dev Gas grows with list size. Recommend <= ~200 recipients/tx depending on gas limits.
    function airdrop(address[] calldata recipients, uint256[] calldata amounts)
        external
        onlyOwner
    {
        require(recipients.length == amounts.length, "Length mismatch");
        for (uint256 i = 0; i < recipients.length; i++) {
            _transfer(msg.sender, recipients[i], amounts[i]); // unified checks inside _transfer
        }
    }

    /// Rescue ERC20 tokens accidentally sent to this contract
    function rescueERC20(address token, uint256 amount, address to) external onlyOwner {
        require(to != address(0), "Zero address");
        require(token != address(this), "Use transfer instead");
        (bool ok, bytes memory data) = token.call(
            abi.encodeWithSignature("transfer(address,uint256)", to, amount)
        );
        require(ok && (data.length == 0 || abi.decode(data, (bool))), "Rescue failed");
        emit Rescue(token, to, amount);
    }

    /// Rescue native BNB accidentally sent to this contract
    function rescueBNB(uint256 amount, address payable to) external onlyOwner {
        require(to != address(0), "Zero address");
        (bool ok, ) = to.call{value: amount}("");
        require(ok, "Rescue BNB failed");
        emit Rescue(address(0), to, amount);
    }

    // Accept BNB (in case someone sends BNB by mistake; enables rescueBNB)
    receive() external payable {}

    // ===== Internal Core =====
    function _transfer(address from, address to, uint256 value) internal {
        require(!paused, "Paused");
        if (!blacklistDisabled) {
            require(!blacklisted[from] && !blacklisted[to], "Blacklisted");
        }
        require(to != address(0), "Transfer to zero");
        uint256 fromBal = _balances[from];
        require(fromBal >= value, "ERC20: balance too low");
        unchecked {
            _balances[from] = fromBal - value;
            _balances[to] += value;
        }
        emit Transfer(from, to, value);
    }

    function _approve(address owner_, address spender, uint256 value) internal {
        require(owner_ != address(0) && spender != address(0), "Zero address");
        _allowances[owner_][spender] = value;
        emit Approval(owner_, spender, value);
    }

    function _mint(address to, uint256 value) internal {
        require(to != address(0), "Mint to zero");
        _totalSupply += value;
        _balances[to] += value;
        emit Transfer(address(0), to, value);
    }

    // (No public burn to keep supply fixed; add if you want deflation later)
}
