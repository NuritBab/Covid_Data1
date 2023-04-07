Select *
from CovidVaccinations

Select DEA.continent, DEA.location, DEA.date, DEA.population, vac.new_vaccinations, 
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) AS RollingPeopleVaccinated
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date
 Where DEA.continent is not null
 order by 2,3

 --Using CTE to be able to use the column we just created,
 
 With PopVSVac (continent,location,date,population,new_vaccinations, RollingPeopleVaccinated)
 as
 (
 Select DEA.continent, DEA.location, DEA.date, DEA.population, vac.new_vaccinations, 
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) AS RollingPeopleVaccinated
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date
 Where DEA.continent is not null
 --order by 2,3
 )
  
 Select *,(RollingPeopleVaccinated/population)*100 As Totslvac
 From PopVSVac


 --Temp table
 Create Table #PrecebtPopulationVaccinated
 (Continent nvarchar (255),
 Location nvarchar (255),
 date datetime,
 population numeric,
 New_vaccination numeric,
 RollingPeopleVaccinated numeric)
 
 insert into #PrecebtPopulationVaccinated
 Select DEA.continent, DEA.location, DEA.date, DEA.population, vac.new_vaccinations, 
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) AS RollingPeopleVaccinated
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date
 Where DEA.continent is not null
 --order by 2,3
 
  
 Select *,(RollingPeopleVaccinated/population)*100 As Totslvac
 From #PrecebtPopulationVaccinated

 
 --Temp table
 Drop Table if exists #PrecebtPopulationVaccinated
 Create Table #PrecebtPopulationVaccinated
 (Continent nvarchar (255),
 Location nvarchar (255),
 date datetime,
 population numeric,
 New_vaccination numeric,
 RollingPeopleVaccinated numeric)
 
 insert into #PrecebtPopulationVaccinated
 Select DEA.continent, DEA.location, DEA.date, DEA.population, vac.new_vaccinations, 
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) AS RollingPeopleVaccinated
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date
 order by 2,3
 
  
 Select *,(RollingPeopleVaccinated/population)*100 As Totslvac
 From #PrecebtPopulationVaccinated

--Creating View to store data for later visualzation

Create view PrecebtPopulationVaccinated as

Select DEA.continent, DEA.location, DEA.date, DEA.population, vac.new_vaccinations, 
 sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) AS RollingPeopleVaccinated
 From CovidDeaths DEA
 join CovidVaccinations VAC
 on DEA.location= VAC.location and DEA.date = VAC.date
 Where dea.continent is not null
-- order by 2,3


Select *
from PrecebtPopulationVaccinated

 



