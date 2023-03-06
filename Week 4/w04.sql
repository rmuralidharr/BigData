// This is CQL for Cassandra

DROP KEYSPACE w04;

// Create keyspace for a single node
CREATE KEYSPACE w04 WITH REPLICATION = { 
		  'class' : 'SimpleStrategy', 
		  'replication_factor' : 1 
}; 

// create a student table for testing
CREATE TABLE IF NOT EXISTS w04.student ( 
    student_id TEXT, 
    f_name TEXT, 
    l_name TEXT, 
    email TEXT, 
    gpa FLOAT, 
    PRIMARY KEY(student_id)
);

// insert values into student table
INSERT INTO w04.student (student_id, f_name, l_name, email, gpa)     
    VALUES ('00001', 'Tim', 'Smith', 'smith515@usf.edu', 4.0);
INSERT INTO w04.student (student_id, f_name, l_name, email, gpa)     
    VALUES ('00002', 'John', 'Jones', 'jjones@somewhere.com', 3.0);
INSERT INTO w04.student (student_id, f_name, l_name, email, gpa)     
    VALUES ('00003', 'Jane', 'Williams', 'jane@somewhere.com', 3.5);

// query the student table
SELECT * from w04.student;
SELECT * from w04.student where gpa = 3.0;

/// issue: do not use ALLOW FILTERING, instead add column to cluster (in primary key) or create an index on the column
CREATE INDEX ON w04.student(gpa); // create index on column

SELECT * from w04.student where gpa = 3.0; // now this works without having to use ALLOW FILTER

// let's say we want to split students into honors, good, at_risk, and failing.
// honors is for students above 3.7, good is above 3, at risk >= 2.5, and failing < 2.5
// let's try to select those students that are honors students...
SELECT * from w04.student where gpa > 3.7; //sthis doesn't work without having to use ALLOW FILTERING

// can you think of a strategy where we could make this work without resorting to ALLOW FILTERING?



// Clean things up
DROP INDEX gpa_index;
DROP TABLE student;
DROP KEYSPACE w04;

// exit cql
exitss