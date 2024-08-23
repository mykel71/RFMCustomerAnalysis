/****************************************************************************************************************************************/
	-- <GenericCodeName>CustomerAnalysis_V001</GenericCodeName>
	-- <CreatedDate>2024-08-17 10:09:13.230</CreatedDate>
	-- <CreatedBy>Michael Shepherd Munemo</CreatedBy>
	-- <GenericCodeAssetTemplate>Create DDL</GenericCodeAssetTemplate>  
/****************************************************************************************************************************************/


/****** Object:  Table [dbo].[Customer_Dataset_1]    Script Date: 2024/08/17 10:13:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer_Dataset_1](
	[transaction_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[transact_date] [date] NOT NULL,
	[revenue] [smallint] NOT NULL,
	[discount_amount] [smallint] NOT NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Customer_Dataset_2]    Script Date: 2024/08/17 10:16:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer_Dataset_2](
	[transaction_id] [int] NOT NULL,
	[customer_id] [nvarchar](50) NOT NULL,
	[transact_date] [date] NOT NULL,
	[revenue] [smallint] NOT NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[RFM_Customer_Dataset_1]    Script Date: 2024/08/17 10:18:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RFM_Customer_Dataset_1](
	[customer_id] [int] NOT NULL,
	[recency] [int] NULL,
	[frequency] [int] NULL,
	[monetary] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[RFM_Customer_Dataset_2]    Script Date: 2024/08/17 10:18:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RFM_Customer_Dataset_2](
	[customer_id] [nvarchar](50) NOT NULL,
	[recency] [int] NULL,
	[frequency] [int] NULL,
	[monetary] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

