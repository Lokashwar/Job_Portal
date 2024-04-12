// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JobPortal {
    
    struct Applicant {
        uint id;
        string name;
        uint age;
        string email;
        string applicationType;
        uint rating;
    }
    
    struct Job {
        uint id;
        string title;
        string description;
        uint salary;
        string location;
    }
    
    mapping (uint => Applicant) applicants;
    mapping (uint => Job) jobs;
    mapping (uint => mapping(uint => uint)) applicantRatings; 
    uint numApplicants;
    uint numJobs;
    
    // Function to add a new applicant
    function addApplicant(string memory _name, uint _age, string memory _email, string memory _applicationType) public {
        numApplicants++;
        applicants[numApplicants] = Applicant(numApplicants, _name, _age, _email, _applicationType, 0);
    }
    
    // Function to get applicant details
    function getApplicantDetails(uint _id) public view returns (string memory name, uint age, string memory email, string memory applicationType) {
        return (applicants[_id].name, applicants[_id].age, applicants[_id].email, applicants[_id].applicationType);
    }
    
    // Function to get applicant type
    function getApplicationType(uint _id) public view returns (string memory applicationType) {
        return applicants[_id].applicationType;
    }
    
    // Function to add a new job
    function addJob(string memory _title, string memory _description, uint _salary, string memory _location) public {
        numJobs++;
        jobs[numJobs] = Job(numJobs, _title, _description, _salary, _location);
    }
    
    // Function to get job details
    function getJobDetails(uint _id) public view returns (string memory jobTitle, string memory description, uint salary, string memory location) {
        return (jobs[_id].title, jobs[_id].description, jobs[_id].salary, jobs[_id].location);
    }

    // Function to apply For job
    function applyForJob(uint _applicantId, uint _jobId) public {
    require(applicants[_applicantId].id != 0, "Invalid applicant ID");
    require(jobs[_jobId].id != 0, "Invalid job ID");
            applicantRatings[_applicantId][_jobId] = 0;
    }
    
    // Function to provide rating to an applicant for a particular job
    function provideApplicantRating(uint _applicantId, uint _jobId, uint _rating) public {
        require(_applicantId <= numApplicants && _jobId <= numJobs, "Invalid applicant or job ID");
        applicantRatings[_applicantId][_jobId] = _rating;
        applicants[_applicantId].rating += _rating;
    }
    
    // Function to fetch applicant rating for a particular job
    function getApplicantRating(uint _applicantId, uint _jobId) public view returns (uint rating) {
        require(_applicantId <= numApplicants && _jobId <= numJobs, "Invalid applicant or job ID");
        return applicantRatings[_applicantId][_jobId];
    }
}






