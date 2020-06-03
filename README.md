# Futbol

**Design Strategy**

We are using encapsulation to split up the statistics in our Stat Tracker class into their own classes based on the type of statistic that they are. We did this to make sure each class had a single responsibility. Our design process started with writing out all the methods first in the Stat Tracker, and then we had an overview of all methods. From there we were easily able to determine which methods had similar functionality and broke them up into their own classes from that point. We also used inheritance to create a designated class that reads the CSV files and distributes them into collections. The different statistics classes inherited from the parent. 
