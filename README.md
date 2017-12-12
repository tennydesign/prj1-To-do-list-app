# My very first project: A To Do List app.
My first iOS App. Well... not quite satisfied with this one, but one has to start somewhere. This project features: 

- Some honest use of OOP. 
- Extensive (and often unnecessary) use of closures. Things like:  activeTasks = (filterTodayTasks() ?? []).filter({ $0.done == false})
- A lot of segues, omg.
- Dateformating.
- Custom cells (give me a break, its my first damn project)
- A lot of dynamic layouting discovery. Things like:  tableView.layoutMargins = UIEdgeInsets.zero
- A fair exploration of the TableView delegate functions
- Absolutely NO auto-layout. 
- A honest attempt to solve a real problem, even with very limited technical resources. 

So my first poject went like this: 

I tried to create a very simple, yet extremely functional task list app. While coding it I tried to challenge myself to solve a real problem, offer something new to TODO Apps but, yet, something users could really find it helpful. The two functionalities that added this flavor to the app are:

Welcome screen gives the user an overview of all tasks due today, regardless of in which "bucket-list" they are. This is to address the fact that people don't look for buckets and then tasks in real life. They just want to be reminded of what they have on deck for today, tomorrow... regardless of how those tasks are organized in the system. The organization in "lists" is great for discoverability, not for taking action.
UX Heuristic #1: Visibility of system status.

The user can see, before clicking on a list, how many "Open" tasks each list have. Open tasks are tasks that are NOT marked as "Done" (instead of having to recall that a specific list has open points).
UX heuristic #6: Recognition rather than recall.

Also, for this first app I tried to draw the Model first, and to create an OOP structure instead of using open arrays and dictionaries.

** This App ranked #1 out of 15 in the the class (General Assembly iOS immersive SF).
Total hacking time: 40 hours.

![firstapp](https://user-images.githubusercontent.com/17029800/33860013-812cf1e4-de8b-11e7-9af0-3e9fdc9bfa51.jpg)

