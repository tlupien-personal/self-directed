/* 
Chapter 13 Exercises 
by: Tim Lupien 
*/

-- Question 1
CREATE TABLE Suffix_Regex_Example (
    full_name VARCHAR(69)
);

INSERT INTO Suffix_Regex_Example (full_name)
VALUES ('Alvarez, Jr.'),
('Williams, Sr.'),
('Octogonapus, Md.');

SELECT replace(full_name, ',', '') AS full_name_no_comma
FROM suffix_regex_example;

--Question 2
WITH just_words (words) AS(
    SELECT(
            (regexp_match(
                concat_ws(
                    '',
                    regexp_match(
                        lower(regexp_split_to_table(speech_text, '\s+|-|--')),
                        '[a-zA-Z0-9]+'
                    )
                ),
                '[a-zA-Z0-9]+'
            )) [1]
        )
    FROM president_speeches
	WHERE sotu_id = 7
)
SELECT count(DISTINCT words)
FROM just_words
WHERE length(words) >= 5;

/*
Why is my answer bizzare and long? 

First, my analysis revealed an extreme prevalence of "-" and "--" to actually 
separate words in these speeches, so I added those to the split. (There was so
much of this I determined the benefit of splitting in this weight outweighed
the loss of the few validly hyphenated compound words)

Next, I was working on removing commas and periods, but realized that many
other punctuation was also used. I further discovered that punctuation would
occur a variable number of times in each "word" created by the split,
sometimes in the middle of a "word" (making regex_replace insufficient. Having
a replace all regex function like python would be nice...). To combat this, I 
pulled only non-punctuation characters from the column, concatenated the 
results to avoid situations where such a match would yield arrays with more
than 1 element, and then matched non-punctuation characters again, taking the
first element of the resultant array, which, in theory, ought to be the full
word.

This was one of a variety of solutions I played around with to solve this
problem. If you know of a better one, think this could cause performance
issues, or thought my explanation was unclear, please 
let me know so I can improve.
*/