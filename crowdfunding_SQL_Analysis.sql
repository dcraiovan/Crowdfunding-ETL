-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT DISTINCT cf_id, backers_count
FROM campaign
WHERE outcome = 'live'
ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_id, COUNT(DISTINCT backer_id) AS backers_count 
FROM backers
GROUP BY cf_id
ORDER BY backers_count DESC;



-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT bac.first_name, bac.last_name, bac.email, sum(cam.goal-cam.pledged) as Remaining_Goal_Amount
INTO email_contacts_remaining_goal_amount
FROM campaign AS cam INNER JOIN contacts AS bac
ON cam.contact_id=bac.contact_id 
WHERE cam.outcome='live'
GROUP BY bac.first_name, bac.last_name, bac.email
ORDER BY  Remaining_Goal_Amount DESC;




-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT bac.email, bac.first_name, bac.last_name, bac.cf_id, cam.company_name, 
cam.description, cam.end_date, sum(cam.goal-cam.pledged) as Left_of_Goal
INTO email_backers_remaining_goal_amount
FROM campaign AS cam INNER JOIN backers AS bac
ON cam.cf_id=bac.cf_id 
WHERE cam.outcome='live'
GROUP BY bac.email, bac.first_name, bac.last_name, bac.cf_id, cam.company_name, cam.description, cam.end_date
ORDER BY bac.last_name;



-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

