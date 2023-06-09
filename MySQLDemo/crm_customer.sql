SELECT
    T_1.Id AS id,
-- T_1.ClientId AS 客户id
    T_2.ClientId AS 客户id
     ,T_NAME.Name AS 客户名称
-- ,T_1.Name AS 客户名称
-- ,T_1.CompanyName AS 公司名称
     ,T_NAME.CompanyName AS 公司名称
     ,CASE T_1.EmpNum WHEN 1 THEN "1-50人" WHEN 2 THEN "51-200人" WHEN 3 THEN "201-500人" WHEN 4 THEN "501-1000人" WHEN 5 THEN "1000人以上" END AS 公司规模

     ,T_DPV.Name AS 省
     ,T_DCT.Name AS 市
     ,T_DDT.Name AS 区
     ,T_1.DetailAddress AS 详情地址
     ,T_PCW.WxName AS 主负责人 -- T_0.PrincipalName
-- ,T_1.Intention 客户来源编号
     ,CASE T_1.Intention WHEN 1 THEN "4K" WHEN 8 THEN "SAAS用户" WHEN 11 THEN "GPM拉群" WHEN 13 THEN "BA独立BD" WHEN 14 THEN "Nicole" WHEN 15 THEN "Group Session" WHEN 16 THEN "渠道" WHEN 17 THEN "GPM名单"  ELSE "-" END AS 客户来源
     ,CASE WHEN T_1.Intention IN (1,16) THEN CASE T_1.IntentionSub WHEN 1 THEN "品牌搜索" WHEN 2 THEN "市场活动" WHEN 3 THEN "媒体渠道" WHEN 5 THEN "SEM推广" WHEN 6 THEN "其他" WHEN 7 THEN "连连" WHEN 9 THEN "闯盟" WHEN 10 THEN "亿丰" WHEN 11 THEN "海猫"WHEN 12 THEN "moonsees" ELSE "-" END
           WHEN T_1.Intention IN (11) THEN T_DGPM.Username
           WHEN T_1.Intention IN (13) THEN T_ITW.WxName
           WHEN T_1.Intention IN (15) THEN T_1.IntentionRemark

           ELSE "-" END AS 渠道明细
-- ,T_ITW.WxName AS 客户来源介绍人 -- ,T_1.Introducer
-- ,T_GPM.Username AS 客户来源选择GPM拉群 -- ,T_1.DragGpmId
-- ,CASE T_1.IntentionSub WHEN 1 THEN "品牌搜索" WHEN 2 THEN "市场活动" WHEN 3 THEN "媒体渠道" WHEN 5 THEN "SEM推广" WHEN 6 THEN "其他" WHEN 7 THEN "连连" WHEN 9 THEN "闯盟" WHEN 10 THEN "亿丰" WHEN 11 THEN "海猫"WHEN 12 THEN "moonsees" ELSE "-" END AS 客户来源二级明细
-- ,T_1.IntentionRemark AS 客户来源GroupSession明细

     ,T_LA_SAAS.FourKName AS saas用户名
     ,T_LA_SAAS.FourKUserId AS saas用户id
-- ,T_1.GpmId
     ,T_GPM.GPMUsername AS 归属GPM
     ,CASE T_LA_SAAS.SaasSource WHEN 1 THEN T_LA_SAAS.LastMonthGmv WHEN 0 THEN T_1.GmvMonth END AS 月Gmv
     ,CONCAT(T_1.StarLevel,"星") AS 星级
     ,T_LBS.FourKName AS 关联Saas用户名
     ,T_LBS.FourKUserId AS 关联SaaS账号Id
     ,GROUP_CONCAT(DISTINCT T_LCA.CategoryName SEPARATOR ',') AS 运营品类
     ,GROUP_CONCAT(DISTINCT T_LCH.ChannelName SEPARATOR ',') AS 运营渠道
-- ,CASE T_LCH.ChannelId WHEN 1 THEN "Amazon" WHEN 2 THEN "沃尔玛" WHEN 3 THEN "独立站" WHEN 4 THEN "Tiktok" WHEN 5 THEN "Ebay" WHEN 6 THEN "shopee" WHEN 7 THEN "Coupang" WHEN 8 THEN "Wayfair" WHEN 9 THEN "Wish" WHEN 10 THEN "国内" WHEN 11 THEN "其他（请备注)" END AS 运营渠道
     ,T_1.Remark AS 备注
     ,T_CON.Name AS 首联系人
     ,T_CON.WeChat AS 微信号
     ,T_CON.PhoneNum AS 电话号码
     ,T_CON.Email AS 邮箱

     ,T_LA1.WxName AS 代运营销售人员
     ,T_LA2.WxName AS "4K Studio销售人员"
     ,T_LA3.WxName AS Coupang销售人员
     ,T_LA4.WxName AS DSP销售人员
     ,T_LA5.WxName AS VC销售人员
     ,T_LA6.WxName AS Saas销售人员
     ,T_LA7.WxName AS 直播销售人员
     ,T_LA8.WxName AS 商务产品销售人员
     ,T_LA9.WxName AS 账号收购销售人员
     ,T_LA10.WxName AS "4K贷销售人员"
     ,T_LA11.WxName AS Editorial销售人员
     ,T_LA15.WxName AS Walmart开账号销售人员
     ,T_LA16.WxName AS "Saas 增值服务销售人员"
     ,T_LA17.WxName AS Sizmek销售人员
     ,T_LA18.WxName AS "Walmart 产品优化大师销售人员"
     ,T_LA19.WxName AS 海外广告投放销售人员

     ,T_1.IsShare AS 是否公海
     ,T_1.IsRecycle AS 是否在线索回收站
     ,CASE T_0.HasSigned WHEN 1 THEN "已签约" ELSE "未签约" END AS 签约情况
     ,T_0.SignAmountUsd AS 签约总金额_美元
     ,T_0.SignAmountCny AS 签约总金额_人民币
     ,T_0.SignBusTypeCount AS 签约业务数

     ,CASE T_0.FourKStatus WHEN 1 THEN "是" ELSE "否" END AS 是否绑定SAAS
     ,T_0.AccountCount AS 绑定店铺数量
     ,T_0.DspSignTotal AS Dsp签约数量
     ,T_0.AdvertiserCount AS Dsp广告主统计

     ,T_0.CreateTime AS 创建时间
     ,T_0.UpdateTime AS 更新时间


/*
,T_1.Remark AS 线索备注
,T_TCOW.WxName AS 线索转客户操作人
,T_1.ToCustomerTime AS 线索转客户时间
,T_TUOW.WxName AS 客户转用户操作人
,T_1.ToUserTime AS 客户转用户时间
,T_TSOW.WxName AS 移入公海操作人
,T_1.ToShareTime AS 移入公海时间
,T_OSOW.WxName AS 公海领取人
,T_1.OutShareTime AS 公海领取时间
,T_SDW.WxName AS 公海分配人
,T_1.ShareDistributeTime AS 公海分配时间
,T_1.IsRecycle AS 是否在线索回收站
,T_1.ToRecycleTime AS 移入回收站时间
,T_TROW.WxName AS 移入回收站操作人
-- ,T_1.LastFollowUpId AS 最后跟进记录(t_indicator_crm_leads_follow_up)
*/
     ,T_CW.WxName AS 线索创建人
-- ,T_1.UpdatorId AS 线索修改人
-- ,T_1.LastUpdateTime AS 最后修改时间_编辑记录
     ,T_1.CreateTime AS 线索创建时间
-- ,T_1.UpdateTime AS 线索更新时间
     ,T_LA.RegisterTime AS 最早注册时间
     ,T_LA.CreateTime AS 最早客户信息创建时间
     ,CASE WHEN T_LA.RegisterTime>0 AND T_LA.CreateTime >0 THEN LEAST(T_0.CreateTime,T_1.CreateTime,T_LA.RegisterTime,T_LA.CreateTime ) WHEN T_LA.CreateTime >0 THEN LEAST(T_0.CreateTime,T_1.CreateTime,T_LA.CreateTime ) WHEN T_LA.RegisterTime>0 THEN LEAST(T_0.CreateTime,T_1.CreateTime,T_LA.RegisterTime ) ELSE LEAST(T_0.CreateTime,T_1.CreateTime) END 最早创建或注册时间





FROM
-- t_indicator_crm_leads
t_indicator_crm_middle_customer T_0
-- CRM系统-线索信息
    LEFT JOIN t_indicator_crm_leads T_1 ON T_0.Id = T_1.Id

-- 说明：CRM系统-客户端对象表
    LEFT JOIN t_indicator_crm_client T_2 ON T_1.Id=T_2.Id

    LEFT JOIN(SELECT a.Id AS Id,a.ClientId AS ClientId,CASE WHEN a.TypeId = 1 AND d.UserName IS NOT NULL THEN d.UserName WHEN a.TypeId = 1 AND d.UserName IS NULL THEN b.Name ELSE c.Name END AS Name,CASE a.TypeId WHEN 1 THEN b.CompanyName ELSE c.CompanyName END AS CompanyName ,e.Name AS TypeName FROM t_indicator_crm_client a LEFT JOIN t_indicator_crm_leads b ON a.Id = b.Id LEFT JOIN t_indicator_crm_platform c ON a.Id = c.Id LEFT JOIN t_indicator_crm_middle_customer d ON a.Id = d.Id LEFT JOIN t_indicator_crm_client_type e ON a.TypeId = e.Id) T_NAME ON T_1.Id=T_NAME.Id

-- 省市区
    LEFT JOIN t_indicator_dictionary_province T_DPV ON T_1.ProvinceCode=T_DPV.Code -- Id
    LEFT JOIN t_indicator_dictionary_city T_DCT ON T_1.CityCode=T_DCT.Code
    LEFT JOIN t_indicator_dictionary_district T_DDT ON T_1.DistrictCode=T_DDT.Code
-- 主负责人
    LEFT JOIN t_indicator_system_user_wx T_PCW ON T_0.Principal=T_PCW.Id
-- Introducer 客户来源介绍人(ba独立bd)
    LEFT JOIN t_indicator_system_user_wx T_ITW ON T_1.Introducer=T_ITW.Id
-- DragGpmId 客户来源选择GPM拉群
    LEFT JOIN t_indicator_gpm_user T_DGPM ON T_1.DragGpmId=T_DGPM.Id

-- 归属GPM，获取客户下所有广告主的gpm
    LEFT JOIN (SELECT a.DspUserId,GROUP_CONCAT(DISTINCT b.Username) AS GPMUsername FROM t_indicator_dsp_advertiser a LEFT JOIN t_indicator_crm_gpm_user b ON a.AeId=b.Id GROUP BY 1 HAVING DspUserId IS NOT NULL) T_GPM ON T_1.Id=T_GPM.DspUserId

    -- LEFT JOIN t_indicator_gpm_user T_GPM ON T_1.GpmId=T_GPM.Id
-- 关联leads扩展表-取SAAS用户名
    LEFT JOIN (SELECT * FROM t_indicator_crm_leads_attach WHERE BusinessTypeId=6) T_LA_SAAS ON T_1.Id=T_LA_SAAS.LeadsId
-- 关联leads扩展表
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =1) T_LA1 ON T_1.Id=T_LA1.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =2) T_LA2 ON T_1.Id=T_LA2.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =3) T_LA3 ON T_1.Id=T_LA3.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =4) T_LA4 ON T_1.Id=T_LA4.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =5) T_LA5 ON T_1.Id=T_LA5.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =6) T_LA6 ON T_1.Id=T_LA6.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =7) T_LA7 ON T_1.Id=T_LA7.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =8) T_LA8 ON T_1.Id=T_LA8.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =9) T_LA9 ON T_1.Id=T_LA9.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =10) T_LA10 ON T_1.Id=T_LA10.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =11) T_LA11 ON T_1.Id=T_LA11.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =15) T_LA15 ON T_1.Id=T_LA15.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =16) T_LA16 ON T_1.Id=T_LA16.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =17) T_LA17 ON T_1.Id=T_LA17.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =18) T_LA18 ON T_1.Id=T_LA18.LeadsId
    LEFT JOIN (SELECT a.LeadsId,a.BusinessTypeId,a.SdrId,b.WxName FROM t_indicator_crm_leads_attach a LEFT JOIN t_indicator_system_user_wx b ON a.SdrId = b.Id WHERE a.BusinessTypeId =19) T_LA19 ON T_1.Id=T_LA19.LeadsId

    LEFT JOIN(SELECT a.LeadsId,MIN(a.RegisterTime) RegisterTime,MIN(a.CreateTime) CreateTime FROM t_indicator_crm_leads_attach a GROUP BY 1)T_LA ON T_1.Id=T_LA.LeadsId

-- 创建人等
    LEFT JOIN t_indicator_system_user_wx T_CW ON  T_1.CreatorId=T_CW.Id
    /*
    -- ,T_1.ToCustomerOperatorId AS 线索转客户操作人
    -- ,T_1.ToUserOperatorId AS 客户转用户操作人
    -- ,T_1.ToShareOperatorId AS 移入公海操作人
    -- ,T_1.OutShareOperatorId AS 公海领取人
    -- ,T_1.ShareDistributorId AS 公海分配人
    -- ,T_1.ToRecycleOpId AS 移入回收站操作人


    LEFT JOIN t_indicator_system_user_wx T_TCOW ON  T_1.ToCustomerOperatorId=T_TCOW.Id
    LEFT JOIN t_indicator_system_user_wx T_TUOW ON  T_1.ToUserOperatorId=T_TUOW.Id
    LEFT JOIN t_indicator_system_user_wx T_TSOW ON  T_1.ToShareOperatorId=T_TSOW.Id
    LEFT JOIN t_indicator_system_user_wx T_OSOW ON  T_1.OutShareOperatorId=T_OSOW.Id
    LEFT JOIN t_indicator_system_user_wx T_SDW ON  T_1.ShareDistributorId=T_SDW.Id
    LEFT JOIN t_indicator_system_user_wx T_TROW ON  T_1.ToRecycleOpId=T_TROW.Id


    */



-- CRM系统-线索信息-SaaS用户绑定
    LEFT JOIN t_indicator_crm_leads_bind_saas T_LBS ON T_1.Id =T_LBS.LeadsId

-- 说明：CRM系统-线索信息-运营品类
    LEFT JOIN (SELECT a.*,b.Name CategoryName FROM t_indicator_crm_leads_category a LEFT JOIN t_indicator_dictionary_amazon_category b ON a.CategoryId=b.Id) T_LCA ON T_1.Id =T_LCA.LeadsId
-- 说明：CRM系统-线索信息-运营渠道
    LEFT JOIN (SELECT a.*,CASE a.ChannelId WHEN 1 THEN "Amazon" WHEN 2 THEN "沃尔玛" WHEN 3 THEN "独立站" WHEN 4 THEN "Tiktok" WHEN 5 THEN "Ebay" WHEN 6 THEN "shopee" WHEN 7 THEN "Coupang" WHEN 8 THEN "Wayfair" WHEN 9 THEN "Wish" WHEN 10 THEN "国内" WHEN 11 THEN "其他（请备注)" END AS ChannelName FROM t_indicator_crm_leads_channel a) T_LCH ON T_1.Id =T_LCH.LeadsId
-- 联系人
    LEFT JOIN t_indicator_crm_contact T_CON ON T_1.Id=T_CON.LeadsId AND T_CON.IsPrimary=1


WHERE  T_0.Id NOT IN (SELECT LeadsId FROM t_indicator_crm_leads_beta)
  -- 剔除测试用户
  AND (NOT FIND_IN_SET(T_0.Principal,(SELECT Value FROM t_indicator_system_config WHERE ConfigId = 10 AND DevelopmentId = (SELECT MAX(DevelopmentId) FROM t_indicator_system_config))) OR T_0.Principal IS NULL)
  -- 剔除测试人员,注意保留销售为空白的
  AND (NOT FIND_IN_SET(T_LA4.SdrId,(SELECT Value FROM t_indicator_system_config WHERE ConfigId = 10 AND DevelopmentId = (SELECT MAX(DevelopmentId) FROM t_indicator_system_config))) OR T_LA4.SdrId IS NULL)
  AND (NOT FIND_IN_SET(T_1.CreatorId,(SELECT Value FROM t_indicator_system_config WHERE ConfigId = 10 AND DevelopmentId = (SELECT MAX(DevelopmentId) FROM t_indicator_system_config))) OR T_1.CreatorId IS NULL)

GROUP BY T_1.Id
ORDER BY T_1.Id ASC