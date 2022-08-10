

--1. Global Numbers
select sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths , (sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage from CovidDeathAnalysis..CovidDeaths$
where continent is not null
order by 1,2

--2. Countries with highest death count per population
select continent, sum(cast(new_deaths as int)) as TotalDeathCount from CovidDeathAnalysis..CovidDeaths$
where continent is not null
and continent not in ('World', 'European Union', 'International')
Group by continent
order by TotalDeathCount desc

--3. Countries with Highest Infection Rate compared to Population
Select continent, location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeathAnalysis..CovidDeaths$
--Where location like '%states%'
Group by continent,location, Population
order by PercentPopulationInfected desc


--4. contintents with the highest death count per population
Select location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeathAnalysis..CovidDeaths$
--Where location like '%states%'
Group by location,Population, date
order by PercentPopulationInfected desc
