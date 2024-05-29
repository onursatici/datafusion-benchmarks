-- SQLBench-DS query 8 derived from TPC-DS query 8 under the terms of the TPC Fair Use Policy.
-- TPC-DS queries are Copyright 2021 Transaction Processing Performance Council.
-- This query was generated at scale factor 1.
select  s_store_name
      ,sum(ss_net_profit)
 from store_sales
     ,date_dim
     ,store,
     (select ca_zip
     from (
      SELECT substr(ca_zip,1,5) ca_zip
      FROM customer_address
      WHERE substr(ca_zip,1,5) IN (
                          '19100','41548','51640','49699','88329','55986',
                          '85119','19510','61020','95452','26235',
                          '51102','16733','42819','27823','90192',
                          '31905','28865','62197','23750','81398',
                          '95288','45114','82060','12313','25218',
                          '64386','46400','77230','69271','43672',
                          '36521','34217','13017','27936','42766',
                          '59233','26060','27477','39981','93402',
                          '74270','13932','51731','71642','17710',
                          '85156','21679','70840','67191','39214',
                          '35273','27293','17128','15458','31615',
                          '60706','67657','54092','32775','14683',
                          '32206','62543','43053','11297','58216',
                          '49410','14710','24501','79057','77038',
                          '91286','32334','46298','18326','67213',
                          '65382','40315','56115','80162','55956',
                          '81583','73588','32513','62880','12201',
                          '11592','17014','83832','61796','57872',
                          '78829','69912','48524','22016','26905',
                          '48511','92168','63051','25748','89786',
                          '98827','86404','53029','37524','14039',
                          '50078','34487','70142','18697','40129',
                          '60642','42810','62667','57183','46414',
                          '58463','71211','46364','34851','54884',
                          '25382','25239','74126','21568','84204',
                          '13607','82518','32982','36953','86001',
                          '79278','21745','64444','35199','83181',
                          '73255','86177','98043','90392','13882',
                          '47084','17859','89526','42072','20233',
                          '52745','75000','22044','77013','24182',
                          '52554','56138','43440','86100','48791',
                          '21883','17096','15965','31196','74903',
                          '19810','35763','92020','55176','54433',
                          '68063','71919','44384','16612','32109',
                          '28207','14762','89933','10930','27616',
                          '56809','14244','22733','33177','29784',
                          '74968','37887','11299','34692','85843',
                          '83663','95421','19323','17406','69264',
                          '28341','50150','79121','73974','92917',
                          '21229','32254','97408','46011','37169',
                          '18146','27296','62927','68812','47734',
                          '86572','12620','80252','50173','27261',
                          '29534','23488','42184','23695','45868',
                          '12910','23429','29052','63228','30731',
                          '15747','25827','22332','62349','56661',
                          '44652','51862','57007','22773','40361',
                          '65238','19327','17282','44708','35484',
                          '34064','11148','92729','22995','18833',
                          '77528','48917','17256','93166','68576',
                          '71096','56499','35096','80551','82424',
                          '17700','32748','78969','46820','57725',
                          '46179','54677','98097','62869','83959',
                          '66728','19716','48326','27420','53458',
                          '69056','84216','36688','63957','41469',
                          '66843','18024','81950','21911','58387',
                          '58103','19813','34581','55347','17171',
                          '35914','75043','75088','80541','26802',
                          '28849','22356','57721','77084','46385',
                          '59255','29308','65885','70673','13306',
                          '68788','87335','40987','31654','67560',
                          '92309','78116','65961','45018','16548',
                          '67092','21818','33716','49449','86150',
                          '12156','27574','43201','50977','52839',
                          '33234','86611','71494','17823','57172',
                          '59869','34086','51052','11320','39717',
                          '79604','24672','70555','38378','91135',
                          '15567','21606','74994','77168','38607',
                          '27384','68328','88944','40203','37893',
                          '42726','83549','48739','55652','27543',
                          '23109','98908','28831','45011','47525',
                          '43870','79404','35780','42136','49317',
                          '14574','99586','21107','14302','83882',
                          '81272','92552','14916','87533','86518',
                          '17862','30741','96288','57886','30304',
                          '24201','79457','36728','49833','35182',
                          '20108','39858','10804','47042','20439',
                          '54708','59027','82499','75311','26548',
                          '53406','92060','41152','60446','33129',
                          '43979','16903','60319','35550','33887',
                          '25463','40343','20726','44429')
     intersect
      select ca_zip
      from (SELECT substr(ca_zip,1,5) ca_zip,count(*) cnt
            FROM customer_address, customer
            WHERE ca_address_sk = c_current_addr_sk and
                  c_preferred_cust_flag='Y'
            group by ca_zip
            having count(*) > 10)A1)A2) V1
 where ss_store_sk = s_store_sk
  and ss_sold_date_sk = d_date_sk
  and d_qoy = 1 and d_year = 2000
  and (substr(s_zip,1,2) = substr(V1.ca_zip,1,2))
 group by s_store_name
 order by s_store_name
  LIMIT 100;

