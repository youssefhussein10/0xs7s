0xs7s Framework
Description
This framework automates the process of detecting XSS (Cross-Site Scripting) vulnerabilities in web applications. It combines reconnaissance, endpoint discovery, and detailed XSS testing into a streamlined pipeline, saving time for bug hunters and penetration testers.

Features
Subdomain Enumeration: Identifies subdomains using subfinder.
Live Host Filtering: Confirms active subdomains with httpx.
Endpoint Discovery: Collects endpoints via gau and katana.
Duplicate Removal: Cleans endpoint lists using uro.
Reflection Testing: Identifies reflection points using Gxss.
XSS Scanning: Detects vulnerabilities with dalfox.
Requirements
Ensure the following tools are installed on your system:

subfinder
httpx
gau
katana
uro
Gxss
dalfox
Installation
Clone the repository:

bash
Copy code
git clone https://github.com/youssefhussein10/0xs7s.git
cd 0xs7s
Make the script executable:

bash
Copy code
chmod +x xss_framework.sh
Usage
Run the script and input your target domain:

bash
Copy code
./xss_framework.sh
Output
Subdomains: subdomains.txt
Live hosts: live_subdomains.txt
Endpoints: endpoints.txt
Filtered endpoints: endpoints_filtered.txt
Reflection points: xss_ref.txt
Vulnerable endpoints: vulnerable_xss.txt
