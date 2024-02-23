######################### SUBNET CIDR BLOCK ######################
subnets = {
  sub_1      = "10.0.20.0/24"
  sub_2      = "10.0.21.0/24"
  sub_3      = "10.0.22.0/24"
  priv_sub_4 = "10.0.30.0/24"
  priv_sub_5 = "10.0.31.0/24"
  priv_sub_6 = "10.0.32.0/24"
}

############################# EC2 AMI ###############################
ami = "ami-0cf10cdf9fcd62d37"
############################ SSH-KEY PUB ###########################
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+BirNn0xOn+yF4VttPe7ldWdaiyZTjfGhK17Rr5aEBMyYzY2Qs18s960WwVhJGIWIr80d21trWLcMEkYak3BWY2h61V596HPo3agA82dLgPOvLuBMiJGKd+mKkCs2knq4x8Ws1nT4ujGC3seHETJNwneQRbDB5vR7v6KjV23Aww1hHpOHjS42Mqivexl7tAaxZH7KdXhH3jGl/LfK+2bqYnJzNfOQnCRQylim7BmNfdyFLWmXQEbcRJVBDTuxbSH3bZdkWasqg2PHMzAPtjWHXvcI1w4dx9JF1OaUKU3rGIcnj953NSA61t2WqXBfQZKd/hxtZs8rUWP0skEAZ37POJIk3cvGe+PnQ2hyxyI/gw3Fj1Hzopk3BOdda2ZKuMF1DFn3Rjc9/XPnr9HHT9jadZuplevJeKoOQmAwlSYnbtNl0moBW3mMKqdJqs5Pj1ISYhqiZGb1z37qLGl68un/qXxgzx4rUI9XX+qwkMfTLMbtb8hOh/6uYBX+N4nIeek= volod@DESKTOP-E88OGSS"

############################ RDS ##################################

allocated_storage   = 20
db_name             = "wordpress"
engine              = "mysql"
engine_version      = 5.7
instance_class      = "db.t2.micro"
storage_type        = "gp2"
username            = "admin"
password            = "adminadmin"
skip_final_snapshot = true
