# SNS topic
resource "aws_sns_topic" "sns_github_enterprise" {
	name = "github-enterprise-alarms"
	display_name = "GitHub Enterprise Alarms"
}

# Load average alarm - warning
resource "aws_cloudwatch_metric_alarm" "LoadAverage15MinWarning" {
    count = 2
	alarm_name = "LoadAverage15MinWarning"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "LoadAverage15Min"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.load_average_warning}"

	dimensions {
		InstanceId = "${aws_instance.ghe-server.id}"
	}
	dimensions {
		InstanceId = "${aws_instance.ghe-failover-server.id}"
	}

	alarm_description = "GitHub - warning for high cpu load average"
	alarm_actions = ["${aws_sns_topic.sns_github_enterprise.arn}"]
}

# Load average alarm - critical
resource "aws_cloudwatch_metric_alarm" "LoadAverage15MinCritical" {
	count = 2
	alarm_name = "LoadAverage15MinCritical"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "LoadAverage15Min"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.load_average_critical}"

	dimensions {
		InstanceId = "${aws_instance.ghe-server.id}"
	}
	dimensions {
		InstanceId = "${aws_instance.ghe-failover-server.id}"
	}

	alarm_description = "GitHub - critical for high cpu load average"
	alarm_actions = ["${aws_sns_topic.sns_github_enterprise.arn}"]
}

# Memory alarm - warning
resource "aws_cloudwatch_metric_alarm" "MemoryWarning" {
	count = 2
	alarm_name = "MemoryWarning"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "MemoryUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.memory_warning}"

	dimensions {
		InstanceId = "${aws_instance.ghe-server.id}"
	}
	dimensions {
		InstanceId = "${aws_instance.ghe-failover-server.id}"
	}

	alarm_description = "GitHub - warning for high memory usage"
	alarm_actions = ["${aws_sns_topic.sns_github_enterprise.arn}"]
}

# Memory alarm - critical
resource "aws_cloudwatch_metric_alarm" "MemoryCritical" {
	count = 2
	alarm_name = "MemoryCritical"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "MemoryUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.memory_critical}"

	dimensions {
		InstanceId = "${aws_instance.ghe-server.id}"
	}
	dimensions {
		InstanceId = "${aws_instance.ghe-failover-server.id}"
	}

	alarm_description = "GitHub - critical for high memory usage"
	alarm_actions = ["${aws_sns_topic.sns_github_enterprise.arn}"]
}

# Disk space alarm - warning
resource "aws_cloudwatch_metric_alarm" "DiskSpaceWarning" {
	count = 2
	alarm_name = "DiskSpaceWarning"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "DiskSpaceUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.diskspace_warning}"

	dimensions {
		InstanceId = "${aws_instance.ghe-server.id}"
	}
	dimensions {
		InstanceId = "${aws_instance.ghe-failover-server.id}"
	}

	alarm_description = "GitHub - warning for low available disk space"
	alarm_actions = ["${aws_sns_topic.sns_github_enterprise.arn}"]
}

# Disk space - critical
resource "aws_cloudwatch_metric_alarm" "DiskSpaceCritical" {
	count = 2
	alarm_name = "DiskSpaceCritical"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "DiskSpaceUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.diskspace_critical}"

	dimensions {
		InstanceId = "${aws_instance.ghe-server.id}"
	}
	dimensions {
		InstanceId = "${aws_instance.ghe-failover-server.id}"
	}
	
	alarm_description = "GitHub - critical for low available disk space"
	alarm_actions = ["${aws_sns_topic.sns_github_enterprise.arn}"]
}