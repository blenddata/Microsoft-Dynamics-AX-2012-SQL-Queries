﻿WITH VENDDIM
AS (SELECT davs.RECID,
           davsi.DISPLAYVALUE,
           davt.NAME
    FROM dbo.DIMENSIONATTRIBUTEVALUESET davs
        LEFT JOIN dbo.DIMENSIONATTRIBUTEVALUESETITEM davsi
            ON davsi.DIMENSIONATTRIBUTEVALUESET = davs.RECID
        LEFT JOIN dbo.DIMENSIONATTRIBUTEVALUE dav
            ON dav.RECID = davsi.DIMENSIONATTRIBUTEVALUE
        LEFT JOIN dbo.DIMENSIONATTRIBUTE da
            ON da.RECID = dav.DIMENSIONATTRIBUTE
        LEFT JOIN dbo.DIMATTRIBUTEVENDTABLE davt
            ON davt.VALUE = davsi.DISPLAYVALUE
    WHERE da.NAME = 'Vendor')
SELECT pt.PURCHID,
       vt.ACCOUNTNUM,
       dpt.NAME VendorName,
       PTVENDDIM.DISPLAYVALUE PurchVendorDimValue,
       PTVENDDIM.NAME PurchVendorDimName,
       VTVENDDIM.DISPLAYVALUE VendorDimValue,
       VTVENDDIM.NAME VendorDimName
FROM dbo.PURCHTABLE pt
    LEFT JOIN dbo.VENDTABLE vt
        ON pt.ORDERACCOUNT = vt.ACCOUNTNUM
    LEFT JOIN dbo.DIRPARTYTABLE dpt
        ON vt.PARTY = dpt.RECID
    LEFT JOIN VENDDIM PTVENDDIM
        ON PTVENDDIM.RECID = pt.DEFAULTDIMENSION
    LEFT JOIN VENDDIM VTVENDDIM
        ON VTVENDDIM.RECID = vt.DEFAULTDIMENSION;