cor
===

Rapid Prototyping Spring 2014 - Cor Web App
Steps to run the dashboard application:
1. Ensure the computer on which you are trying to run the code has ruby 2.0.0 and rails 4.0 installed.
	If not please follow the instructions at http://www.railstutorial.org/book/beginning#sec-rails_installer_windows
	The above link contains instructions for both Windows and unix platforms.
	For development we used sqlite3. It should get installed automatically when following the above instructions, else install separately(we never encountered this situation).
2. Once the necessary installations are done, navigate to the extreacted 'cor-dashboard' folder using command prompt/terminal
3. Run the commands 'bundle update' and 'bundle install' if this is the first time you are running the application on this machine. It installs the required libraries used by the application automatically.
4. Run the 'rake db:migrate' command if this is the first time you are running the application on this machine. It creates the development database. You may run this command later if you need to recreate the development database.
5. Run the 'rake db:random' command to generate mock data in the development database. You may run this whenever you want to regenerate mock up to date data.
6. Run the 'rails server' to start the development server. Once running, the application can be accessed using any web browser using the following urls:
	'localhost:3000' for the patient dashboard
	'localhost:3000/physician/roster' for the physician dashboard