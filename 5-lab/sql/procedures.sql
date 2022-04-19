with ranges as (
    select count(*) as n_procedures,
           case
               when date_part('year', age(birthday)) < 30 then '< 30'
               when date_part('year', age(birthday)) between 30 and 40 then '30 - 40'
               when date_part('year', age(birthday)) between 40 and 50 then '40 - 50'
               when date_part('year', age(birthday)) between 50 and 60 then '50 - 60'
               when date_part('year', age(birthday)) > 60 then '> 60'
            end as range
    from patient
             join patient_procedure on patient.id = patient_procedure.patient_id
    group by patient.id
)
select range, avg(n_procedures)
from ranges
group by range
order by range;