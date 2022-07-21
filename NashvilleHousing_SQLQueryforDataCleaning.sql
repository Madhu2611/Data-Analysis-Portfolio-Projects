select * from [Housing Project].dbo.NashvilleHousing

--Standardize Date format(convert from datetime to date)
select SaleDate,CONVERT(date,SaleDate)
from [Housing Project].dbo.NashvilleHousing

Update [Housing Project].dbo.NashvilleHousing
set SaleDate=CONVERT(date,SaleDate)

Alter table [Housing Project].dbo.NashvilleHousing
add SaleDateConverted date

Update [Housing Project].dbo.NashvilleHousing
set SaleDateConverted=CONVERT(date,SaleDate) 

--Populate PropertyAddress data
select *
from [Housing Project].dbo.NashvilleHousing
where PropertyAddress is null

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Housing Project].dbo.NashvilleHousing a
join [Housing Project].dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Housing Project].dbo.NashvilleHousing a
join [Housing Project].dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

--Breaking down Address into individual columns(Adress,City,State)
--Using SUBSTRING
select PropertyAddress
from [Housing Project].dbo.NashvilleHousing

select SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
from [Housing Project].dbo.NashvilleHousing 

select SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)) as Address
from [Housing Project].dbo.NashvilleHousing

Alter table [Housing Project].dbo.NashvilleHousing
add PropertySplitAddress Nvarchar(225)

Update [Housing Project].dbo.NashvilleHousing
set PropertySplitAddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

Alter table [Housing Project].dbo.NashvilleHousing
add PropertySplitCity Nvarchar(225)

Update [Housing Project].dbo.NashvilleHousing
set PropertySplitCity=SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

--Using PARSENAME
 select OwnerAddress
 from [Housing Project].dbo.NashvilleHousing

 select PARSENAME(REPLACE(OwnerAddress,',','.'),3),
 PARSENAME(REPLACE(OwnerAddress,',','.'),2),
 PARSENAME(REPLACE(OwnerAddress,',','.'),1)
 from [Housing Project].dbo.NashvilleHousing

 Alter table [Housing Project].dbo.NashvilleHousing
add OwnerSplitAddress Nvarchar(225)

Update [Housing Project].dbo.NashvilleHousing
set OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3)

Alter table [Housing Project].dbo.NashvilleHousing
add OwnerSplitCity Nvarchar(225)

Update [Housing Project].dbo.NashvilleHousing
set OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress,',','.'),2)

Alter table [Housing Project].dbo.NashvilleHousing
add OwnerSplitState Nvarchar(225)

Update [Housing Project].dbo.NashvilleHousing
set OwnerSplitState=PARSENAME(REPLACE(OwnerAddress,',','.'),1)

--Change Y and N to YEs and No in SoldAsVacant column
select SoldAsVacant,count(SoldAsVacant)
from [Housing Project]..NashvilleHousing
group by SoldAsVacant
order by SoldAsVacant

select SoldAsVacant,
case when SoldAsVacant= 'Y' then 'Yes'
 when SoldAsVacant='N' then 'No'
else SoldAsVacant
end
from [Housing Project]..NashvilleHousing

update [Housing Project]..NashvilleHousing
set SoldAsVacant= case when SoldAsVacant= 'Y' then 'Yes'
 when SoldAsVacant='N' then 'No'
else SoldAsVacant
end

--Remove Duplicates
with RowNumCTE as(
select *,
ROW_NUMBER() over(
PARTITION BY ParcelID,PropertyAddress,SalePrice,SaleDate,LegalReference
ORDER BY UniqueID)row_num
from [Housing Project]..NashvilleHousing)

Delete from RowNumCTE
where row_num>1
--order by PropertyAddress


--Delete Unused Columns
Alter table [Housing Project]..NashvilleHousing
drop column OwnerAddress,TaxDistrict,PropertyAddress

select * from [Housing Project]..NashvilleHousing

