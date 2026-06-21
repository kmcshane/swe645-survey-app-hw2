Name: Karen McShane

S3 URL: http://kmcshan4-swe-645.s3-website-us-east-1.amazonaws.com
For S3 deployment I simply created the S3 bucket and uploaded the files from my browser

EC2 URL: http://ec2-54-167-112-17.compute-1.amazonaws.com
For EC2 deployment I started off my creating an t3.micro Ubuntu image. For the web server I used Nginx as that's what I have experience using. I installed it using "apt".
Deploying the app meant simply copying my files to the correct directory in my instance (in my case /var/www/html)
For my files I had to install the awscli and do an "aws s3 cp" command to copy them from my s3 bucket
\*Before running the aws cli command I had to ensure an IAM role was attached to my instance

For styling my HTML elements I used Bootstrap

Background: https://uiverse.io/chase2k25/giant-pug-85
I got the background for my homepage from this user on uiverse.io
