LOAD Data
infile 'data.txt'
Append
into TABLE Employee_Profile
Fields terminated by ','
(EMPID                ,    
RESUME_FILE_NAME FILLER CHAR(500),
RESUME     LOBFILE(RESUME_FILE_NAME) TERMINATED BY EOF,             
PROFILE_PIC_FILE_NAME             FILLER CHAR(100),
PROFILE_PIC             LOBFILE(PROFILE_PIC_FILE_NAME) TERMINATED BY EOF)