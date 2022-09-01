// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import "@openzeppelin/contracts/utils/math/Math.sol";
import '@openzeppelin/contracts/access/Ownable.sol';



interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}


// Dependency file: contracts/interfaces/IUniswapV2Router02.sol

// pragma solidity >=0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}


interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IReward {
function addReward(uint256 amount) external;
}

interface IRelation {
function Inviter(address addr) external view returns (address);
function taskStats(address addr) external view returns (bool);
function record(address addr0, address token, uint256 amount,address addr) external;
function deposit(uint256 amount) external;
}


interface IWKNFT {
    function getNFTlvl(address _addr) external view returns (uint256);
    function nftID(address _addr) external view returns (uint256);
}


contract WK is ERC20Burnable, Ownable{
    using SafeMath for uint256;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;
    address public constant USDTToken = 0x55d398326f99059fF775485246999027B3197955;
    address public wknft;
    uint256 public tradeFee;
    uint256 public WKMarkPrice; 
    uint256 public markTime;  
    address public Relation;
    uint256 public transferFee;
    uint256 public lpRenewAmount;
    uint256 public nftRenewAmount;
    uint256 public totalLPAmount;
    uint256 public totalNFTAmount;
    uint256 public nftStartTime;
    uint256 public startTime;
    bool public checkOpen = true;
    bool public rewardRenew = false;
    bool public renewPriceOpen = true;

    address public _nftAddress = 0x3125646ad77efb1B02d8Aa8e69d3C628d0d8D209;
    address public _lpAddress;
    address public _burnAddress;
    address public _fund0Address  = 0xBFceEE5366F93072Eec2ba7CEfFD4965f3C2d755;
    address public _fundAddress  = 0xc57214d45287aCb346FC120E43b5cDEB3E3f3be0;
    address public constant _operationAddress = 0x2402B0C8418A319E640D11e17F8861867cB8a386;
    address public constant _communityAddress = 0x8CED23E6efaf7cb6aF5Ece3ee6E292Ac744ae9D6;
    mapping(address => bool) public _isExcludedFromFees;

    event UpdateUniswapV2Router(
        address indexed newAddress,
        address indexed oldAddress
    );
    event ExcludeFromFees(address indexed account, bool isExcluded);
    

    constructor(string memory name_, string memory symbol_,address nft_, uint256 markTime_,address relation_,address lpAddress_)
        ERC20(name_, symbol_)
    {
        _mint(_burnAddress, 600 * 10**12 * 10**18);
        _mint(_fund0Address, 100 * 10**12 * 10**18);
        _mint(_communityAddress, 100 * 10**12 * 10**18);
        _mint(_operationAddress, 200 * 10**12 * 10**18);
        markTime = markTime_;
        Relation = relation_;
        _lpAddress = lpAddress_;
        wknft = nft_;
        IUniswapV2Router02 _uniswapV2Router  = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        // Create a uniswap pair for this new token
        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), USDTToken);
        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = _uniswapV2Pair;  
        _isExcludedFromFees[_nftAddress] = true;
        _isExcludedFromFees[_lpAddress] = true;
        _isExcludedFromFees[_fundAddress] = true;
        _isExcludedFromFees[address(this)] = true;
        _isExcludedFromFees[_operationAddress] = true;
        _isExcludedFromFees[_communityAddress] = true;
    }
    

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        if (amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        bool takeFee = true;

        // if any account belongs to _isExcludedFromFee account then remove the fee
        if (_isExcludedFromFees[from] || _isExcludedFromFees[to]) {
            takeFee = false;
        }

        if (takeFee) {
        renewMarkPrice();



        if(from == uniswapV2Pair) {


            uint256 nftAmount = amount .mul(3).div(100); 
            uint256 lpAmount = amount .mul(5).div(100);
            uint256 burnAmount = amount .mul(15).div(1000);
            uint256 fundAmount = amount .mul(5).div(1000);
            super._transfer(from, _nftAddress, nftAmount);
            super._transfer(from, _lpAddress, lpAmount);  
            super._transfer(from, _fundAddress, fundAmount);  
            super._transfer(from, _burnAddress, burnAmount);  
            totalLPAmount += lpAmount; 
            totalNFTAmount += nftAmount; 
            amount = amount.sub(nftAmount).sub(lpAmount).sub(burnAmount).sub(fundAmount);
            if(rewardRenew && totalLPAmount > lpRenewAmount){
            IReward(_lpAddress).addReward(totalLPAmount);
            totalLPAmount = 0;
            }
            if(rewardRenew && totalNFTAmount > nftRenewAmount){
            IReward(_nftAddress).addReward(totalNFTAmount);
            totalNFTAmount = 0;
            }
            if(checkOpen){
            uint256 ilvl = IWKNFT(wknft).getNFTlvl(msg.sender);
            uint256 WKCurrentPrice = getWKPrice();
            uint256 value = (balanceOf(to)+amount) * WKCurrentPrice;
            if(ilvl > 0){
            require(block.timestamp > nftStartTime);
            if(ilvl ==1){
            require(value <= 400 * 10 ** 18);
            }
            else if(ilvl ==2){
            require(value <= 200 * 10 ** 18);
            }
            else if(ilvl ==3){
            require(value <= 100 * 10 ** 18);
            } 
            else if(ilvl ==4){
            require(value <= 50 * 10 ** 18);
            }            
            }
            else{
            require(block.timestamp > startTime);
            }
        }


        }

        if(to == uniswapV2Pair) {
            getTradeFee();
            uint256 nftAmount = amount.mul(27).div(1000);
            uint256 fundAmount = amount.mul(45).div(10000);
            uint256 lpAmount = amount.mul(45).div(1000);
            uint256 invAmount = amount.mul(30).div(1000);
            uint256 burnAmount = amount.mul(300 + 135 + tradeFee).div(10000);
            amount = amount.sub(nftAmount).sub(lpAmount).sub(invAmount).sub(burnAmount); 
            totalLPAmount += lpAmount;    
            super._transfer(from, _nftAddress, nftAmount);
            super._transfer(from, _lpAddress, lpAmount);
            address cur = from;
            for (uint256 i = 0; i < 10; i++) {
            cur = IRelation(Relation).Inviter(cur);
            if (cur == address(0)) {
                break;
            }else{
            if(IRelation(Relation).taskStats(cur)){
            uint256 invReward = amount.mul(3).div(1000);
            invAmount = invAmount - invReward;
            super._transfer(from, cur , invReward);
            }
            }
            }
            super._transfer(from, _burnAddress, invAmount+burnAmount);  
            if(rewardRenew && totalLPAmount > lpRenewAmount){
            IReward(_lpAddress).addReward(totalLPAmount);
            totalLPAmount = 0;
            }
            if(rewardRenew && totalNFTAmount > nftRenewAmount){
            IReward(_nftAddress).addReward(totalNFTAmount);
            totalNFTAmount = 0;
            }
        }

        if(from != uniswapV2Pair && to != uniswapV2Pair) {
            require(amount <= balanceOf(from).mul(99).div(100),"Exceed the Limit");
            uint256 transferAmount = amount.mul(90).div(100);    
            amount = amount.sub(transferAmount);      
            super._transfer(from, _burnAddress, transferAmount);     
        }  
        }
        super._transfer(from, to, amount);
        return;
    }

    function getTradeFee() internal {
        tradeFee = 0;
        uint256 WKCurrentPrice = getWKPrice();
        if(WKCurrentPrice <= WKMarkPrice * 95 / 100){
        tradeFee =  Math.min(3000, (((WKMarkPrice - WKCurrentPrice) * 10000 / WKMarkPrice)-50)*3);
        }
    }

    function getWKPrice() public view returns(uint256) {
        address token0 = IUniswapV2Pair(uniswapV2Pair).token0();
        address token1 = IUniswapV2Pair(uniswapV2Pair).token1();
        (uint112 token0Amount,uint112 token1Amount,)=IUniswapV2Pair(uniswapV2Pair).getReserves();
        uint256 price0 = uint256(token0Amount) * 10**18 / uint256(token1Amount);
        uint256 price1 = uint256(token1Amount) * 10**18 / uint256(token0Amount);
        if(token0 == USDTToken){
            return price0;
        }
            return price1;
    }

    function renewMarkPrice() public {
        if(block.timestamp >= markTime && renewPriceOpen){
        WKMarkPrice = getWKPrice();
        markTime = markTime + 86400;
        }
    }

    function updateUniswapV2Router(address newAddress) public onlyOwner {
        require(
            newAddress != address(uniswapV2Router),
            "WK: The router already has that address"
        );
        emit UpdateUniswapV2Router(newAddress, address(uniswapV2Router));
        uniswapV2Router = IUniswapV2Router02(newAddress);
        address _uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory())
            .createPair(address(this), USDTToken);
        uniswapV2Pair = _uniswapV2Pair;
    }

    function excludeFromFees(address account, bool excluded) public onlyOwner {
        require(
            _isExcludedFromFees[account] != excluded,
            "WK: Account is already the value of 'excluded'"
        );
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }


    function setlpRenewAmount(uint256 value) external onlyOwner {
        lpRenewAmount = value;
        emit LpRenewAmountSet(value);
    }

    function setCheckOpen(bool value) external onlyOwner {
        checkOpen = value;
        emit CheckOpenSet(value);
    }

    function setNFTStartTime(uint256 value) external onlyOwner {
        nftStartTime = value;
        emit NFTStartTimeSet(value);
    }

    function setStartTime(uint256 value) external onlyOwner {
        startTime = value;
        emit StartTimeSet(value);
    }

    function setRewardRenew(bool value) external onlyOwner {
        rewardRenew = value;
        emit RewardRenewFeeSet(value);
    }

    function setRenewPriceOpen(bool value) external onlyOwner {
        renewPriceOpen = value;
        emit RenewPriceOpenSet(value);
    }

    function setMarkPrice(uint256 value) external onlyOwner {
        WKMarkPrice = value;
        emit MarkPriceSet(value);
    }


    event NFTStartTimeSet(uint256 value);
    event StartTimeSet(uint256 value);
    event LpRenewAmountSet(uint256 value);
    event RewardRenewFeeSet(bool value);
    event RenewPriceOpenSet(bool value);
    event CheckOpenSet(bool value);
    event MarkPriceSet(uint256 value);
    event TokenMinted(address _mintAddress,uint256 amount);

}
