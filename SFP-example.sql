-- Sentence where Particles that are part of a discontinuous construction (e.g. mai6 … lo1): 200 rows
select distinct full_chinese, romanization from
	(SELECT mai6.sent_num
	FROM
		(SELECT sent_num FROM words WHERE roman = 'mai6') as mai6
	INNER JOIN
		(SELECT sent_num FROM words WHERE roman = 'lo1') as lo1
	ON mai6.sent_num = lo1.sent_num) as mai_lo
inner join full_sentence
on (mai_lo.sent_num = full_sentence.sent_num)
;

-- Creat a full_sentence table for future queries
-- insert into full_sentence SELECT sent_num, group_concat(chi_char) as "Full Chinese", group_concat(roman) as "Romanization" FROM words group by sent_num;

-- All types question particles
select distinct full_chinese, romanization from
	(select sent_num from (select words.* from words inner join (select sent_num, sent_seq from words where pos = 7) as pos7 on (words.sent_num = pos7.sent_num and words.sent_seq = pos7.sent_seq - 1) ) as res
	where res.pos = 6) as pos6_q
inner join full_sentence
on pos6_q.sent_num = full_sentence.sent_num;

-- Yes/No question particles (a statement + SFP -> a question)

select distinct full_chinese, romanization
from
	(select * 
	from
		(select res_before.chi_char as word_before, words.chi_char as word_after, words.sent_num from words
		inner join
			(select words.chi_char, neg.sent_num, neg.sent_seq from words
			inner join
			(select sent_num, sent_seq from words where chi_char = '唔') as neg
			on (words.sent_num = neg.sent_num and words.sent_seq = neg.sent_seq - 1)) as res_before
		on (words.sent_num = res_before.sent_num and words.sent_seq = res_before.sent_seq + 1)) as res_both
	where word_before = word_after) as xnegx
inner join full_sentence
on (xnegx.sent_num = full_sentence.sent_num)
;

-- Wh-Question particles 

select distinct full_chinese, romanization from
(select * from words
where chi_char 
IN ('邊個','邊度','點解','點樣','邊處','乜嘢','乜','幾時','幾耐','幾多'))as ques
inner join full_sentence
on (ques.sent_num = full_sentence.sent_num)
; 

-- Share the same basic particle but come with various tonal variants (e.g. aa1, aa3, aa6)
select distinct full_chinese, romanization from
(select * from words 
where pos = '6' and roman = 'aa1') as aa1
inner join full_sentence
on (aa1.sent_num = full_sentence.sent_num)
union
select distinct full_chinese, romanization from
(select * from words 
where pos = '6' and roman = 'aa3') as aa3
inner join full_sentence
on (aa3.sent_num = full_sentence.sent_num)
union
select distinct full_chinese, romanization from
(select * from words 
where pos = '6' and roman = 'aa6') as aa6
inner join full_sentence
on (aa6.sent_num = full_sentence.sent_num)
;

-- Used after adverbials (POS tag: ‘D’ pos_num = '4' or ‘C’, pos_num='26')
select distinct full_chinese, romanization from
	(select adv.sent_num from
		(select * from words 
		where pos = 4 or pos = 26) as adv
	inner join
		(select * from words
		where pos = 6) as sfp
	on adv.sent_num = sfp.sent_num and adv.sent_seq = sfp.sent_seq - 1) as adv_sfp
inner join full_sentence
on (adv_sfp.sent_num = full_sentence.sent_num)
;


-- Find all examples of right dislocation 
select distinct full_chinese, romanization from 
	(select * from
		(select words.sent_num, words.pos, words.chi_char from words
		inner join
			(select sent_num, sent_seq from words 
			where pos = 6) as sfp
		on words.sent_num = sfp.sent_num and words.sent_seq = sfp.sent_seq + 1) as after_sfp
	where pos not in (7, 13, 78, 48, 6)) as final_string -- not ('?','.','!') and not sfp
inner join full_sentence
on (final_string.sent_num = full_sentence.sent_num)
;

-- Clusters: more than one SFPs
select distinct full_chinese, romanization from 
	(select * from
		(select words.sent_num, words.pos, words.chi_char from words
		inner join
			(select sent_num, sent_seq from words 
			where pos = 6) as sfp
		on words.sent_num = sfp.sent_num and words.sent_seq = sfp.sent_seq + 1) as after_sfp
	where pos = 6) as final_string -- is sfp
inner join full_sentence
on (final_string.sent_num = full_sentence.sent_num);



