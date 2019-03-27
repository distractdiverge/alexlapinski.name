+++
title = "Typescript Lambda"
date = 2019-03-25T21:58:52-04:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
categories = ["AWS", "Typescript"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

# Typescript AWS Lambda Example
This is a simple project to test out AWS Lambda with Typescript.

In addition, the infrastructure for this project is deployed using terraform.

## Overview
This project is a simple TODO application.
There are tasks which are in a list.
Each task has a title, date, and priority.
Additionally a task can be completed or incomplete.

## Local Development
### 1. Clone this Repository
### 2

## Deployment
### 1. Install Prerequisites
#### Terraform
### 2. Setup AWS Provider
#### 

## Infrastrcture
The infrastructure in AWS is defined as follows.

![Infrastructure](./docs/images/infrastructure.svg)
[view on cloudcraft](https://cloudcraft.co/view/8bdc040f-fe19-4fee-a2c1-931452855373?key=IX2gJcdrcRUp4VvyFukOvw)

### Overall Cost
**Cost based on 128mb Memory, No cache for API Gateway & 1 second for each request to process**
Estimated Cost (based on volume of requests & <= 25 GB data)
| Requests Per Day  | Cost Per Day |
| ------------------|--------------|
|           ~1, 000 | $0.04 |
|          ~10, 000 | $0.07 |
|         ~100, 000 | $0.41 |
|      ~1, 000, 000 | $5.79 |

### Speed of execution
This can start to really increase the cost.
**Note: Just Lambda Cost shown, w/ 128 mb**

For example, if we have 100k req. per day, and our execution time changes, we have the following:
| Length of Execution | Cost per Day |
| ------------------- | ------------ |
| 1 sec | $0.01 |
| 2 sec | $0.22 |
| 3 sec | $0.44 |
| 10 sec | $1.94 |
| 60 sec | $12.71 |
| 120 sec | $25.63 |

So... if your code is going to take more than 1 or 2 seconds, it'll start to add up, and you might just want an EC2 instance.

#### Burst Execution
The good news though, is that even if your script runs for the max 500 seconds, and you execute less than 1000 times per month, it'll only cost $0.19 a day, with the maximum memory allocated, or $0.06 per day, with 1GB ram, or free if the max memory is less than 896mb.

What this really means is that Lambdas are REALLY good if you execute something infrequently, and not too bad if you have moderate volume, still less frequently.

### Storage Cost
Then if we were to see how the cost increases as our storage does:
Estimated Cost of storage
| Size (in GB) | Base Cost of Storage per Day |
|--------------| -----------------------------|
|  <= 25 GB    |      $0.04 |
|     50 GB    |      $0.25 |
|    250 GB    |      $1.91 |
|    500 GB    |      $4.00 |