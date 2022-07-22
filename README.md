# Pewlett-Hackard-Analysis
A large company, realized that in coming years many employees would nearing retirement age, and requested analysis of employees in order to prepare for the mass exodus. Records were parsed with SQL through postgress to determine retirement eligable employees, potential retirement numbers per department and titles. Additionally, to prepare for training of new employees as others retire, analysis was done on current employees who would be eligable for a mentorship program. Retirement conditions were supplied by the company, looking at persons born between 1952-1955 who are currently employeed. 


-----------------------------------

##**Overview**
  Number of retiring employees per title and those eligible for mentorship programs were desired in addition to base analysis.

Analysis was completed with postgress using SQL. Information from company records were used to create tables for employees, managers, departments, employees per department, salaries, and titles. Information from company records were used to create tables for employees, managers, departments, employees per department, salaries, and titles. The following entity relationship diagram (ERD) was created to show relationships, primary and foreign keys between tables. Visualization of ERD was created with Quick DBD. These base relationships were used to access desired information for retirement per title and mentorship program eligibility. 

![EmployeeDB](https://user-images.githubusercontent.com/100040705/166059942-36ff97e0-c567-4dc4-b294-02467854bdab.png)

Retirement eligible employees were defined as those born between 1952-1955. Mentorship eligibility was was defined as those born in 1965. Currently employment by the company was additionally required for both. 

A sample of code used to create these queries is as follows: 
- Full code used may be found in the Employee_Database_challenge.sql file. 

![Screenshot_sample_code_mentor](https://user-images.githubusercontent.com/100040705/166063430-90214c6a-cb30-4876-8978-eac9a0275b3b.png)

  Code used to query tables for mentorship eligibility. 


-----------------------------------


##**Results**

- Retirement Eligibility
  - Results from retirement by title shows over 50,000 employees are eligible for retirement within the company. The highest turn over rate will occur for Senior Engineers, with over 25,000 employees retiring with that current title. Senior Staff follows closely with just under 25,000 retiring.The lowest retirement rate will occur for managers, with only 2 employees expected to retire soon.
  - Senior members of staff are by far the highest title of employees due to retire, with lower title levels being lower.
  - A complete list of currently eligible employees may be found in the unique_titles csv. A sample of this file is as shown below:

![Screenshot_table_unique_titles](https://user-images.githubusercontent.com/100040705/166062816-54c2822f-9cef-4d47-b689-267757e3d186.png)


  - The resulting table of retirement eligible employees, grouped by department is as shown:

![Screenshot_table_retiring_titles](https://user-images.githubusercontent.com/100040705/166062644-c598cb20-cea1-4f5c-96fb-8a3610e80cea.png)
 

- Mentorship Program Eligibility
  - Many of the eligible mentors are in leadership roles such as senior staff or engineers. 
  - There are over 1,500 employees eligible for the program with the current requirements. This is significantly less than the number retiring, so each would have approximately 30 personel to mentor if they were evenly distributed. 
  - A complete list of currently mentorship eligible employees may be found in the mentorship_eligibility.csv. A sample of this file is as shown below.

![screenshot_table_mentorship_eligibility](https://user-images.githubusercontent.com/100040705/166062906-9b2b4108-3fe7-40d8-aa97-c45732694acb.png)


-----------------------------------


##**Summary**
- Due to the high turnover of senior engineers and staff, the company will have to put the most resources in finding new employees in these areas. As there are not nearly as many engineers or staff member in junior levels retiring, promotion paths in these area may be a way to distribute the burden of replacement in these areas. This could additionaly aid to maintain a strong leadership and longevity within the company.
- Additional analysis should be done to determine the mentorship status of personel per title or department. This would give more insight into if there will be enough in house training for new or promoted employees. If it is determined there are not enough mentors to help smooth the new employee transition, new requirements for the program such as quarterly reviews could be considered, or the age of employees considered could be broadened.
- Analysis of age of senior title employees throughout the company could help prevent a high turn over of the highest trained personel in the future. Focus on distribution of age through training of younger team members with high potenital in their fields could prevent such high retirement of senior titled or high level team members in the future.

---------------------------------------

##**Contact Me**

Email: sarahhumphrey2016@outlook.com </br>
[LinkedIn](https://www.linkedin.com/in/sarah-humphrey-data-analyst/)
