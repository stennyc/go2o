namespace go define

include "ttype.thrift"

// 支付服务
service PaymentService{
    // 创建支付单并提交
    ttype.Result SubmitPaymentOrder(1:SPaymentOrder o)
    // 根据支付单号获取支付单
    SPaymentOrder GetPaymentOrder(1:string orderNo)
    // 根据交易号获取支付单编号
    i32 GetPaymentOrderId(1:string tradeNo)
    // 根据编号获取支付单
    SPaymentOrder GetPaymentOrderById(1:i32 id)
    // 调整支付单金额
    ttype.Result AdjustOrder(1:string paymentNo, 2:double amount)
    // 余额抵扣
    ttype.Result DiscountByBalance(1:i32 orderId,2:string remark )
   // 积分抵扣支付单
    ttype.Result DiscountByIntegral(1:i32 orderId,2:i64 integral,3:bool ignoreOut)
    // 钱包账户支付
    ttype.Result PaymentByWallet(1:i32 orderId,2:string remark)
    // 余额钱包混合支付，优先扣除余额。
    ttype.Result HybridPayment(1:i32 orderId,2:string remark)
    // 完成支付单支付，并传入支付方式及外部订单号
    ttype.Result FinishPayment(1:string tradeNo ,2:string spName,3:string outerNo)

    // 支付网关
    ttype.Result GatewayV1(1:string action,2:i64 userId,3:map<string,string> data)
    // 获取支付所需数据
    map<string,string> GetPaymentOrderInfo(1:string tradeNo,2:bool mergeTrade)
}

/** 支付单 */
struct SPaymentOrder{
    /** 编号 */
    1:i32 ID
    /** 卖家编号 */
    2:i32 SellerId
    /** 交易类型 */
    3:string TradeType
    /** 交易号 */
    4:string TradeNo
    /** 合并支付交单单号 */
    5:string MergeTradeNo
    /** 支付单详情 */
    6:string Subject
    /** 订单号 */
    7:i32 OrderId
    /** 支付单的类型，如购物或其他 */
    8:i32 OrderType
    /** 外部订单号 */
    9:string OutOrderNo
    /** 买家编号 */
    10:i32 BuyerId
    /** 支付用户编号 */
    11:i32 PayUid
    /** 商品金额 */
    12:i32 ItemAmount
    /** 优惠金额  */
    13:i32 DiscountAmount
    /** 调整金额 */
    14:i32 AdjustAmount
    /** 抵扣金额  */
    15:i32 DeductAmount
    /** 共计金额 */
    16:i32 TotalAmount
    // 手续费
    17:i32 ProcedureFee
    /** 最终支付金额 */
    18:i32 FinalFee
    /** 可⽤支付方式  */
    19:i32 PayFlag
    /** 其他支付信息 */
    20:string ExtraData
    /** 交易支付渠道 */
    21:i32 TradeChannel
    /** 外部交易提供商 */
    22:string OutTradeSp
    /** 外部交易订单号 */
    23:string OutTradeNo
    /** 订单状态 */
    24:i32 State
    /** 提交时间 */
    25:i64 SubmitTime
    /** 过期时间 */
    26:i64 ExpiresTime
    /** 支付时间 */
    27:i64 PaidTime
    /** 更新时间 */
    28:i64 UpdateTime
    /** 交易途径交易信息 */
    29:list<SPayTradeChan> TradeChannels
}

/** 支付单项 */
struct SPayTradeChan{
    /** 编号 */
    1:i32 ID
    /** 交易单号 */
    2:i32 TradeNo
    /** 支付途径 */
    3:i32 PayChan
    /** 是否为内置支付途径 */
    4:i32 InternalChan
    /** 支付金额 */
    5:i32 PayAmount
}
