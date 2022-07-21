select * from [Housing Project]..NashvilleHousing
where [UniqueID ]=2045

--Properties by City
select PropertySplitCity,count(PropertySplitCity)
 from [Housing Project]..NashvilleHousing
 group by PropertySplitCity
 order by count(PropertySplitCity)

 --Properties sold by year
 select year(SaleDate),count(year(SaleDate))
 from [Housing Project]..NashvilleHousing
 group by year(SaleDate)
 order by year(SaleDate)

 --Properties available based on number of bedrooms
 select Bedrooms,count(Bedrooms)
 from [Housing Project]..NashvilleHousing
 where Bedrooms is not null
 group by Bedrooms
 order by Bedrooms

 --Properties by LandUse
 select LandUse,count(LandUse)
 from [Housing Project]..NashvilleHousing
 group by LandUse
 order by count(LandUse)

 --Properties by number of Bathrooms
  select HalfBath,count(HalfBath)
  from [Housing Project]..NashvilleHousing
  where HalfBath is not null
  group by HalfBath
  order by HalfBath