/* 
cleaning data in sql queries
*/
select * from PortfolioProject.dbo.NashivleHousing

--standardize DateFormat
select SaleDate ,CONVERT(Date,SaleDate)
from PortfolioProject.dbo.NashivleHousing

UPDATE NashivleHousing
SET SaleDate=CONVERT(Date,SaleDate)

ALTER TABLE NashivleHousing Add 
SaleDateConverted Date;

Update NashivleHousing
SET SaleDateConverted=CONVERT(Date,SaleDate)

select SaleDateConverted ,CONVERT(Date,SaleDate)
from PortfolioProject.dbo.NashivleHousing

--popular property Address data

select*
from PortfolioProject.dbo.NashivleHousing
--Where PropertyAddress is null
order by ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, 
ISNULL(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashivleHousing a
JOIN PortfolioProject.dbo.NashivleHousing b
on a.ParcelID=b.ParcelID
AND a.[UniqueID ] <>b.[UniqueID ]
Where a.PropertyAddress is null

Update a 
SET PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashivleHousing a
JOIN PortfolioProject.dbo.NashivleHousing b
on a.ParcelID=b.ParcelID
AND a.[UniqueID ] <>b.[UniqueID ]
Where a.PropertyAddress is null

--Breaking Addres into Individual Columns (Address,City,State)


select PropertyAddress
from PortfolioProject.dbo.NashivleHousing
--Where PropertyAddress is null
--order by ParcelID

Select SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)
as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))
as Address
from PortfolioProject.dbo.NashivleHousing

ALTER TABLE NashivleHousing Add 
PropertysplitAddress Nvarchar(255);

Update NashivleHousing
SET PropertysplitAddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashivleHousing Add 
PropertysSplitCity Nvarchar(255);

Update NashivleHousing
SET PropertysSplitCity =SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))



SELECT * FROM PortfolioProject.dbo.NashivleHousing 

SELECT OwnerAddress FROM PortfolioProject.dbo.NashivleHousing 

SELECT PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM PortfolioProject.dbo.NashivleHousing 

ALTER TABLE NashivleHousing Add 
OwnersplitAddress Nvarchar(255);

Update NashivleHousing
SET OwnersplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashivleHousing Add 
OwnerSplitCity Nvarchar(255);

Update NashivleHousing
SET OwnerSplitCity =PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashivleHousing Add 
OwnerSplitState Nvarchar(255);

Update NashivleHousing
SET OwnerSplitState =PARSENAME(REPLACE(OwnerAddress,',','.'),1)

SELECT * FROM PortfolioProject.dbo.NashivleHousing

--Change Y and N Yes and No in "Sold as Vacant" field