#!/bin/bash
# Cập nhật hệ thống
sudo yum update -y
# Cài đặt ECS Agent nếu chưa có
sudo amazon-linux-extras install ecs

# # Thêm cấu hình ECS cluster
sudo echo ECS_CLUSTER=my-ecs-cluster >> /etc/ecs/ecs.config

# # Tạo thư mục /etc/ecs/
# sudo mkdir -p /etc/ecs

# # Kích hoạt và khởi động ECS Agent
# sudo systemctl enable ecs
# sudo systemctl start ecs