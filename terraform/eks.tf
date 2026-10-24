module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  kubernetes_version = "1.33"

  name                   = local.name
  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }
  
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
# ADD THIS BLOCK TO CREATE EC2 WORKER NODES:
  eks_managed_node_groups = {
    general = {
      name            = "general-node-group"
      instance_types  = ["t3.medium"] # Change to your preferred instance type
      
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  
  # control_plane_subnet_ids = module.vpc.intra_subnets
  # 
  # eks_managed_node_groups = {
  #   amc-cluster-wg = {
  #     min_size     = 1
  #     max_size     = 4
  #     desired_size = 1
  # 
  #     ami_type                              = "AL2023_x86_64_STANDARD"
  #     instance_types                        = ["m5.large"]
  #     attach_cluster_primary_security_group = false
  #     capacity_type                         = "ON_DEMAND"
  #   }
  # }
  # 
  # addons = {
  #   coredns = {
  #     most_recent = true
  #   }
  #   kube-proxy = {
  #     most_recent = true
  #   }
  #   vpc-cni = {
  #     most_recent = true
  #   }
  # }
}
