module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             = aws_vpc.sample-vpc.id
  subnets            = ["subnet-0e6b3ea6c9fe12cb7","subnet-0e58e962d0ae8bf59","subnet-0e7786caadbb7d361"]
  security_groups    = ["sg-0e38ec18c9cb0c4da"]

  /*access_logs = {
    bucket = "virat-0987"
  }*/

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-021612a3dab78fa2d"
          port = 80
        }
       /* my_other_target = {
          target_id = "i-a1b2c3d4e5f6g7h8i"
          port = 8080
        }*/
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Dev"
    name: "my-alb"
  }
}