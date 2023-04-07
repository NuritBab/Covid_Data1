Select *
From CovidDeaths
where continent is not null
order by 3,4
--Select *
--From CovidVaccinations
--order by 3,4

--Select Location,date,Total_Cases,new_cases, Total_Deaths,population
--From CovidDeaths
--order by 1,2

--looking at total cases Vs total detahs

Select Location,date,Total_Cases, Total_Deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
order by 1,2

-- looking at total case vs the population
Select Location,date, population, Total_Cases,(total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
Where location like '%states%'
order by 1,2

--looking at countries with highest infection rate compared to population


Select Location,population, max(Total_Cases)as highesInfectionCount,max((total_cases/population))*100 as percentagepopulationInfected
From CovidDeaths
--Where location like '%states%'
Group by Location,Population
order by percentagepopulationInfected desc

--Breaking thing up by continent
Select continent, max(cast (total_deaths as int))as TotalDeathCount
From CovidDeaths
where continent is not null
Group by continent
order by TotalDeathCount desc


--Showing countries with highset death count per population
Select Location, max(cast (total_deaths as int))as TotalDeathCount
From CovidDeaths
where continent is not null
Group by Location,population
order by TotalDeathCount desc


--showing the continent with the highest death count

Select continent, max(cast (total_deaths as int))as TotalDeathCount
From CovidDeaths
where continent is not null
Group by continent,
order by TotalDeathCount desc



--Global Numbers

 select date,sum(new_cases) as TotalCases ,sum(cast(new_deaths as int)) as TotalDeaths
 From CovidDeaths
 where continent is not null
 Group by date
 order by 1,2

 select date,sum(new_cases)as TotalCases,sum(cast(new_deaths as int)) as TotalDeaths, Sum (cast(new_deaths as int))/sum(new_cases)*100 As DeathPercetntage
From CovidDeaths
 where continent is not null
Group by date
 order by 1,2

  --joined both tables on date+location
 Select *
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date

 --Looking at totalpopulation Vs Vaccination

 Select DEA.continent, DEA.location, DEA.date, DEA.population, vac.new_vaccinations, 
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) AS RollingPeopleVaccinated
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date
 Where DEA.continent is not null
 order by 2,3

 
 -- Using CTE beacuse we want to use a colimn we just cr
 Select DEA.continent, DEA.location, DEA.date, DEA.population, vac.new_vaccinations, 
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) AS RollingPeopleVaccinated
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date
 Where DEA.continent is not null
 order by 2,3
