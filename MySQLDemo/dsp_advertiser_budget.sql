SELECT
    T_2.Id Adv_Id
     ,T_2.AdvertiserId AS AdvertiserId
     ,T_2.AdvertiserName AS AdvertiserName
     ,CASE T_2.AdvertiserStatus
          WHEN 1 THEN "pending approval"
          WHEN 2 THEN "live"
          WHEN 3 THEN "paused"
          WHEN 4 THEN "cancelled"
          ELSE "-" END AS  AdvertiserStatus
     ,T_DE.EntityId AS EntityId
     ,T_DE.EntityName AS EntityName
     ,T_3.Id User_Id
     ,T_3.ClientId AS ClientId
     ,T_3.Name AS UserName
     ,T_3.CompanyName AS CompanyName
     ,T_5.WxName AS BaName
     ,T_SC.ServiceCenter AS ServiceCenter_BA
     ,T_AMSC.ServiceCenter AS ServiceCenter_AM
     ,T_6.WxName AS AmName
     ,T_7.Username AS GPM
     ,T_8.DeliverStartDate AS DeliverStartDate
     ,T_9.DeliverStartDate AS DeliverStartDate_User
     ,CASE T_2.PrimaryCategory WHEN 1 THEN "Apparel" WHEN 2 THEN "Automotive" WHEN 3 THEN "Baby" WHEN 4 THEN "Beauty" WHEN 5 THEN "Biss" WHEN 6 THEN "Camera" WHEN 7 THEN "Electronics" WHEN 8 THEN "Furniture" WHEN 9 THEN "Grocery" WHEN 10 THEN "Health & Personal Care" WHEN 11 THEN "Home" WHEN 12 THEN "Home Entertainment" WHEN 13 THEN "Home Improvement" WHEN 14 THEN "Jewelry" WHEN 15 THEN "Kitchen" WHEN 16 THEN "Lawn and Garden" WHEN 17 THEN "Luggage" WHEN 18 THEN "Major Appliances" WHEN 19 THEN "Musical Instruments" WHEN 20 THEN "Office Products" WHEN 21 THEN "Outdoors" WHEN 22 THEN "PC" WHEN 23 THEN "Personal_Care_Appliances" WHEN 24 THEN "Pet Products" WHEN 25 THEN "Shoes" WHEN 26 THEN "Softlines Private Label" WHEN 27 THEN "Sports" WHEN 28 THEN "Tools" WHEN 29 THEN "Toys" WHEN 30 THEN "Video Games" WHEN 31 THEN "Watches" WHEN 32 THEN "Wireless" END AS PrimaryCategory
     ,CASE T_2.SiteId WHEN 3 THEN "US" WHEN 4 THEN "CA" WHEN 1 THEN "UK" WHEN 6 THEN "DE" WHEN 7 THEN "FR" WHEN 2 THEN "IT" WHEN 8 THEN "ES" WHEN 20 THEN "IN" WHEN 14 THEN "JP" WHEN 23 THEN "AU" END AS Site
     ,DATE_FORMAT(STR_TO_DATE(T_1.Belongmonth,'%Y-%m-01'),'%Y%m%01')  AS BelongMonth
     ,T_1.TotalCostUsd AS TotalCostUsd
     ,T_1.FirstMdpBudgetUsd AS FMdpBudgetUsd
     ,T_1.MdpBudgetUsd AS MdpBudgetUsd
     ,T_1.FirstMdpBudgetDr AS FMdpBudgetDr
     ,T_1.MdpBudgetDr AS MdpBudgetDr
FROM t_indicator_dsp_advertiser_budget AS T_1
         LEFT JOIN t_indicator_dsp_advertiser AS T_2 ON T_1.AdvertiserId = T_2.Id
         LEFT JOIN t_indicator_dsp_entity T_DE ON T_2.EntityId=T_DE.Id
         LEFT JOIN (SELECT a.Id AS Id,a.ClientId AS ClientId,CASE WHEN a.TypeId = 1 AND d.UserName IS NOT NULL THEN d.UserName WHEN a.TypeId = 1 AND d.UserName IS NULL THEN b.Name WHEN a.TypeId = 2 THEN c.Name ELSE "" END AS Name,CASE a.TypeId WHEN 1 THEN b.CompanyName WHEN 2 THEN c.CompanyName ELSE "" END AS CompanyName FROM t_indicator_crm_client a LEFT JOIN t_indicator_crm_leads b ON a.Id = b.Id LEFT JOIN t_indicator_crm_platform c ON a.Id = c.Id LEFT JOIN t_indicator_crm_middle_customer d ON a.Id = d.Id) AS T_3 ON T_1.DspUserId = T_3.Id /* 20220512更新*/ -- CRM系统-线索信息
         LEFT JOIN (SELECT * FROM t_indicator_crm_leads_attach WHERE BusinessTypeId =4) AS T_4 ON T_1.DspUserId = T_4.LeadsId
         LEFT JOIN t_indicator_system_user_wx AS T_5 ON T_4.SdrId = T_5.Id
         LEFT JOIN t_indicator_system_user_wx AS T_6 ON T_2.AmId =T_6.Id
         LEFT JOIN t_indicator_crm_gpm_user AS T_7 ON T_2.AeId = T_7.Id
         LEFT JOIN (SELECT AdvertiserId AS AdvertiserId,MIN(ReportDate) AS DeliverStartDate,MAX(ReportDate) AS RecentDeliverDate  FROM t_indicator_dsp_reports_campaign_advertiser GROUP BY 1) AS T_8 ON T_1.AdvertiserId = T_8.AdvertiserId
         LEFT JOIN (SELECT DspUserId AS DspUserId,MIN(ReportDate) AS DeliverStartDate,MAX(ReportDate) AS RecentDeliverDate  FROM t_indicator_dsp_reports_campaign_user GROUP BY 1) AS T_9 ON T_1.DspUserId = T_9.DspUserId
         LEFT JOIN (SELECT a.Id,a.WxName,CASE WHEN a.WxName IN("段骋森","陈飞燕","欧丹丹","陆咏仪","白彦桑") THEN "广州服务中心" WHEN a.WxName IN("廖骏","金美娜","刘嘉鑫","萧瑾") THEN "京沪服务中心" WHEN a.WxName IN("张思钊","郑晓纯","谭胤") THEN "深圳服务中心" ELSE (CASE WHEN b.ServiceCenter IN (1,7) THEN "广州服务中心" WHEN b.ServiceCenter IN (2,11) THEN "杭州服务中心" WHEN b.ServiceCenter IN (3,10) THEN "厦门服务中心" WHEN b.ServiceCenter IN (4,12,6,9,31) THEN "京沪服务中心" WHEN b.ServiceCenter IN (5,8) THEN "深圳服务中心" ELSE "项目中心" END) END AS ServiceCenter FROM t_indicator_system_user_wx a LEFT JOIN t_indicator_crm_roster b ON a.Id =b.WxUserId GROUP BY a.Id) T_SC ON T_4.SdrId =T_SC.Id
         LEFT JOIN (SELECT a.Id,a.WxName,CASE WHEN a.WxName IN("段骋森","陈飞燕","欧丹丹","陆咏仪","白彦桑") THEN "广州服务中心" WHEN a.WxName IN("廖骏","金美娜","刘嘉鑫","萧瑾") THEN "京沪服务中心" WHEN a.WxName IN("张思钊","郑晓纯","谭胤") THEN "深圳服务中心" ELSE (CASE WHEN b.ServiceCenter IN (1,7) THEN "广州服务中心" WHEN b.ServiceCenter IN (2,11) THEN "杭州服务中心" WHEN b.ServiceCenter IN (3,10) THEN "厦门服务中心" WHEN b.ServiceCenter IN (4,12,6,9,31) THEN "京沪服务中心" WHEN b.ServiceCenter IN (5,8) THEN "深圳服务中心" ELSE "项目中心" END) END AS ServiceCenter FROM t_indicator_system_user_wx a LEFT JOIN t_indicator_crm_roster b ON a.Id =b.WxUserId GROUP BY a.Id) T_AMSC ON T_2.AmId = T_AMSC.Id

WHERE
-- T_4.SdrId NOT IN(SELECT Value FROM t_indicator_system_config WHERE ConfigId = 10)	-- 剔除测试账号
    (NOT FIND_IN_SET(T_4.SdrId,(SELECT Value FROM t_indicator_system_config WHERE ConfigId = 10 AND DevelopmentId = (SELECT MAX(DevelopmentId) FROM t_indicator_system_config))))
  AND T_1.DspUserId NOT IN (SELECT LeadsId FROM t_indicator_crm_leads_beta)


GROUP BY T_2.AdvertiserId,T_1.Belongmonth