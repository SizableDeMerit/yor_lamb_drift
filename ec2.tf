#per https://docs.bridgecrew.io/docs/networking_4
# FROM Brdigecrew
# A VPC comes with a default security group that has an initial setting denying all inbound traffic,
# allowing all outbound traffic, and allowing all traffic between instances assigned to the security group.
# We recommend that your default security group restricts all inbound and outbound traffic.
# FROM TERRAFORM 
# The following config gives the default security group the same rules that AWS provides by default but under 
# management by Terraform. This means that any ingress or egress rules added or changed will be detected as drift.

resource "awxs_vpc" "mainvpc" {
  # checkov:BC_AWS_NETWORKING_4: Ensure default VPC restricst all traffic 
  # and again
  cidr_block = "10.1.0.0/16"
}

resource "aws_default_security_group" "default" {
  # checkov:BC_AWS_NETWORKING_4: Ensure default VPC restricst all traffic 
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "95462415bf093a3e8578bb4007ab377160edcda5"
    git_file             = "ec2.tf"
    git_last_modified_at = "2022-04-05 15:05:30"
    git_last_modified_by = "102994153+SizableDeMerit@users.noreply.github.com"
    git_modifiers        = "102994153+SizableDeMerit/97243784+mouth-calcite/sized-demerit-0u"
    git_org              = "SizableDeMerit"
    git_repo             = "yor_lamb_drift"
    yor_trace            = "8d4b96bd-a7ba-436b-8e8c-1bdb3cc4dbfc"
  }
}


resource "aws_flow_log" "example" {
  iam_role_arn    = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.example.id
  tags = {
    git_commit           = "95462415bf093a3e8578bb4007ab377160edcda5"
    git_file             = "ec2.tf"
    git_last_modified_at = "2022-04-05 15:05:30"
    git_last_modified_by = "102994153+SizableDeMerit@users.noreply.github.com"
    git_modifiers        = "102994153+SizableDeMerit"
    git_org              = "SizableDeMerit"
    git_repo             = "yor_lamb_drift"
    yor_trace            = "c26b7257-d7b4-4288-915d-1987711721a3"
  }
}

resource "aws_cloudwatch_log_group" "example" {
  # checkov:skip=BC_AWS_LOGGING_13: ENSURE CLOUD WATCH LOG GROUP SPECIFIES RETENTION DAYS
  # checkov:skip=BC_AWS_GENERAL_85: ENSURE CLOUD WATCH IS ENCRYPTED BY KMS 
  name              = "example"
  retention_in_days = 90
  tags = {
    git_commit           = "95462415bf093a3e8578bb4007ab377160edcda5"
    git_file             = "ec2.tf"
    git_last_modified_at = "2022-04-05 15:05:30"
    git_last_modified_by = "102994153+SizableDeMerit@users.noreply.github.com"
    git_modifiers        = "102994153+SizableDeMerit"
    git_org              = "SizableDeMerit"
    git_repo             = "yor_lamb_drift"
    yor_trace            = "340e0bcc-464f-41b7-9cee-aab589091cde"
  }
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    git_commit           = "95462415bf093a3e8578bb4007ab377160edcda5"
    git_file             = "ec2.tf"
    git_last_modified_at = "2022-04-05 15:05:30"
    git_last_modified_by = "102994153+SizableDeMerit@users.noreply.github.com"
    git_modifiers        = "102994153+SizableDeMerit/97243784+mouth-calcite"
    git_org              = "SizableDeMerit"
    git_repo             = "yor_lamb_drift"
    yor_trace            = "e6cb8435-1183-44d6-aaf7-01a8786bbde6"
  }
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = aws_iam_role.example.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}




# resource "aws_instance" "web_host" {
#   # ec2 have plain text secrets in user data
#   ami           = "${var.ami}"
#   instance_type = "t2.nano"

#   vpc_security_group_ids = [
#   "${aws_security_group.web-node.id}"]
#   subnet_id     = "${aws_subnet.web_subnet.id}"
#   user_data     = <<EOF
# #! /bin/bash
# sudo apt-get update
# sudo apt-get inst
# all -y apache2
# sudo systemctl start apache2
# sudo systemctl enable apache2
# export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMAAA
# export AWS_SECRET_ACCESS_KEY=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
# export AWS_DEFAULT_REGION=us-west-2
# echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
# EOF
#   monitoring    = true
#   ebs_optimized = true
#   tags = {
#     git_commit           = "2f3136f98bda5a6599656436b4dae9b9ab99a1fa"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:30:53"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "ee37c4ed-d943-446e-9f53-7022a8fd48b0"
#   }
# }



# resource "aws_ebs_volume" "web_host_storage" {
#   # unencrypted volume
#   availability_zone = "${var.region}a"
#   #encrypted         = false  # Setting this causes the volume to be recreated on apply 
#   size = 1

#   encrypted = true
#   tags = {
#     yor_trace            = "77594094-7748-4832-a133-f11d446a6bb0"
#     git_commit           = "e27b3a95d72a16b9d1e487f08629cfc996273652"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 20:08:56"
#     git_last_modified_by = "sized-demerit-0u@icloud.com"
#     git_modifiers        = "97243784+mouth-calcite/sized-demerit-0u"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#   }
# }


# resource "aws_ebs_snapshot" "example_snapshot" {
#   # ebs snapshot without encryption
#   volume_id   = "${aws_ebs_volume.web_host_storage.id}"
#   description = "${local.resource_prefix.value}-ebs-snapshot"
#   tags = merge({
#     Name = "${local.resource_prefix.value}-ebs-snapshot"
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "c1008080-ec2f-4512-a0d0-2e9330aa58f0"
#   })
# }

# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sdh"
#   volume_id   = "${aws_ebs_volume.web_host_storage.id}"
#   instance_id = "${aws_instance.web_host.id}"
# }

# resource "aws_security_group" "web-node" {
#   # security group is open to the world in SSH port
#   name        = "${local.resource_prefix.value}-sg"
#   description = "${local.resource_prefix.value} Security Group"
#   vpc_id      = aws_vpc.web_vpc.id

#   ingress {
#     from_port = 80
#     to_port   = 80
#     protocol  = "tcp"
#     cidr_blocks = [
#     "0.0.0.0/0"]
#   }
#   ingress {
#     from_port = 22
#     to_port   = 22
#     protocol  = "tcp"
#     cidr_blocks = [
#     "0.0.0.0/0"]
#   }
#   egress {
#     from_port = 0
#     to_port   = 0
#     protocol  = "-1"
#     cidr_blocks = [
#     "0.0.0.0/0"]
#   }
#   depends_on = [aws_vpc.web_vpc]
#   tags = {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "b7af1b40-64eb-4519-a1a0-ab198db4b193"
#   }
# }

# resource "aws_vpc" "web_vpc" {
#   cidr_block           = "172.16.0.0/16"
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   tags = merge({
#     Name = "${local.resource_prefix.value}-vpc"
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "9bf2359b-952e-4570-9595-52eba4c20473"
#   })
# }

# resource "aws_subnet" "web_subnet" {
#   vpc_id                  = aws_vpc.web_vpc.id
#   cidr_block              = "172.16.10.0/24"
#   availability_zone       = "${var.region}a"
#   map_public_ip_on_launch = true

#   tags = merge({
#     Name = "${local.resource_prefix.value}-subnet"
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "0345f650-d280-4ca8-86c9-c71c38c0eda8"
#   })
# }

# resource "aws_subnet" "web_subnet2" {
#   vpc_id                  = aws_vpc.web_vpc.id
#   cidr_block              = "172.16.11.0/24"
#   availability_zone       = "${var.region}b"
#   map_public_ip_on_launch = true

#   tags = merge({
#     Name = "${local.resource_prefix.value}-subnet2"
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "224af03a-00e0-4981-be30-14965833c2db"
#   })
# }


# resource "aws_internet_gateway" "web_igw" {
#   vpc_id = aws_vpc.web_vpc.id

#   tags = merge({
#     Name = "${local.resource_prefix.value}-igw"
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "d8e63cb4-2fb5-4726-9c86-5fd05ef03674"
#   })
# }

# resource "aws_route_table" "web_rtb" {
#   vpc_id = aws_vpc.web_vpc.id

#   tags = merge({
#     Name = "${local.resource_prefix.value}-rtb"
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "5e4fee6e-a6aa-4b61-a741-47c5efb463e1"
#   })
# }

# resource "aws_route_table_association" "rtbassoc" {
#   subnet_id      = aws_subnet.web_subnet.id
#   route_table_id = aws_route_table.web_rtb.id
# }

# resource "aws_route_table_association" "rtbassoc2" {
#   subnet_id      = aws_subnet.web_subnet2.id
#   route_table_id = aws_route_table.web_rtb.id
# }

# resource "aws_route" "public_internet_gateway" {
#   route_table_id         = aws_route_table.web_rtb.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.web_igw.id

#   timeouts {
#     create = "5m"
#   }
# }


# resource "aws_network_interface" "web-eni" {
#   subnet_id   = aws_subnet.web_subnet.id
#   private_ips = ["172.16.10.100"]

#   tags = merge({
#     Name = "${local.resource_prefix.value}-primary_network_interface"
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "7e2ffea8-739f-467d-b57b-53cbc0d7ccbe"
#   })
# }

# # VPC Flow Logs to S3
# resource "aws_flow_log" "vpcflowlogs" {
#   log_destination      = aws_s3_bucket.flowbucket.arn
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   vpc_id               = aws_vpc.web_vpc.id

#   tags = merge({
#     Name        = "${local.resource_prefix.value}-flowlogs"
#     Environment = local.resource_prefix.value
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "6808d4b7-45bc-4d1d-9523-96757a3add3a"
#   })
# }

# resource "aws_s3_bucket" "flowbucket" {
#   bucket        = "${local.resource_prefix.value}-flowlogs"
#   force_destroy = true

#   tags = merge({
#     Name        = "${local.resource_prefix.value}-flowlogs"
#     Environment = local.resource_prefix.value
#     }, {
#     git_commit           = "930a419758c2d9492a45bcb23b99436712fa80e8"
#     git_file             = "ec2.tf"
#     git_last_modified_at = "2022-04-04 19:16:54"
#     git_last_modified_by = "97243784+mouth-calcite@users.noreply.github.com"
#     git_modifiers        = "97243784+mouth-calcite"
#     git_org              = "SizableDeMerit"
#     git_repo             = "yor_lamb_drift"
#     yor_trace            = "f058838a-b1e0-4383-b965-7e06e987ffb1"
#   })
# }

# output "ec2_public_dns" {
#   description = "Web Host Public DNS name"
#   value       = aws_instance.web_host.public_dns
# }

# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.web_vpc.id
# }

# output "public_subnet" {
#   description = "The ID of the Public subnet"
#   value       = aws_subnet.web_subnet.id
# }

# output "public_subnet2" {
#   description = "The ID of the Public subnet"
#   value       = aws_subnet.web_subnet2.id
# }
