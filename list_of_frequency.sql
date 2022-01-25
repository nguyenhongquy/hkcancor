-- 1. list all SFPs with frequency in database
CREATE VIEW list_of_sfps AS
SELECT roman, chi_char, count(chi_char) FROM words
WHERE pos = '6'
GROUP BY roman, chi_char
ORDER BY roman;

-- Most common SFPs
CREATE VIEW `list_of_sfps` AS
    SELECT 
        `words`.`roman` AS `Romanization`,
        `words`.`chi_char` AS `Chinese character`,
        COUNT(`words`.`chi_char`) AS `frequency`
    FROM
        `words`
    WHERE
        (`words`.`pos` = '6')
    GROUP BY `words`.`roman` , `words`.`chi_char`
    ORDER BY `words`.`roman`
    

SELECT * FROM Cantonese.list_of_sfps
ORDER BY frequency DESC
;

-- list of SFPs in 6 tones
SELECT RIGHT(Romanization,1) AS Tone, Romanization, `Chinese character`
FROM list_of_sfps 
ORDER BY Tone;

-- The most common tones 
SELECT RIGHT(Romanization,1) AS Tone, COUNT(Romanization) As `Tonal Frequency`
FROM list_of_sfps 
GROUP BY Tone
ORDER BY `Tonal Frequency` DESC;

-- SFPs with coda k
SELECT  Romanization, `Chinese character`
FROM list_of_sfps 
WHERE LEFT(RIGHT(Romanization,2), 1) = 'k'
ORDER BY Romanization;


-- SFPs (ryhmes with coda)
SELECT  LEFT(RIGHT(Romanization,3), 1) as `Finals`, Romanization, `Chinese character`
FROM list_of_sfps 
WHERE Romanization RLIKE '[aeiou][^aeiou].$'
ORDER BY `Finals`;

-- SFPs by rhymes (no coda)
SELECT  LEFT(RIGHT(Romanization,2), 1) as `Finals`, count(Romanization) as frequency
FROM list_of_sfps 
WHERE Romanization RLIKE '[aeiou].$'
GROUP BY Finals
ORDER BY frequency desc;

-- SFPs by rhymes
select Finals, count(Roman)
from 
(SELECT  LEFT(RIGHT(Romanization,2), 1) as `Finals`, Romanization as `Roman`
FROM list_of_sfps 
WHERE Romanization RLIKE '[aeiou].$'
UNION ALL
SELECT  LEFT(RIGHT(Romanization,3), 1), Romanization
FROM list_of_sfps 
WHERE Romanization RLIKE '[aeiou][^aeiou].$'
) as tempTab
group by Finals
-- ORDER BY frequency desc;

