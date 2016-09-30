# SNS topic
resource "aws_sns_topic" "sns_github_backup" {
	name = "github-backup-alarms"
	display_name = "GitHub Backup Alarms"
}

# Load average alarm - warning
resource "aws_cloudwatch_metric_alarm" "LoadAverage15MinWarning" {
	alarm_name = "LoadAverage15MinWarning"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "LoadAverage15Min"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.load_average_warning}"

	alarm_description = "GitHub - warning for high cpu load average"
	alarm_actions = ["${aws_sns_topic.sns_github_backup.arn}"]
}

# Load average alarm - critical
resource "aws_cloudwatch_metric_alarm" "LoadAverage15MinCritical" {
	alarm_name = "LoadAverage15MinCritical"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "LoadAverage15Min"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.load_average_critical}"

	alarm_description = "GitHub - critical for high cpu load average"
	alarm_actions = ["${aws_sns_topic.sns_github_backup.arn}"]
}

# Memory alarm - warning
resource "aws_cloudwatch_metric_alarm" "MemoryWarning" {
	alarm_name = "MemoryWarning"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "MemoryUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.memory_warning}"

	alarm_description = "GitHub - warning for high memory usage"
	alarm_actions = ["${aws_sns_topic.sns_github_backup.arn}"]
}

# Memory alarm - critical
resource "aws_cloudwatch_metric_alarm" "MemoryCritical" {
	alarm_name = "MemoryCritical"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "MemoryUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.memory_critical}"

	alarm_description = "GitHub - critical for high memory usage"
	alarm_actions = ["${aws_sns_topic.sns_github_backup.arn}"]
}

# Disk space alarm - warning
resource "aws_cloudwatch_metric_alarm" "DiskSpaceWarning" {
	alarm_name = "DiskSpaceWarning"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "DiskSpaceUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.diskspace_warning}"

	alarm_description = "GitHub - warning for low available disk space"
	alarm_actions = ["${aws_sns_topic.sns_github_backup.arn}"]
}

# Disk space - critical
resource "aws_cloudwatch_metric_alarm" "DiskSpaceCritical" {
	alarm_name = "DiskSpaceCritical"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "1"
	metric_name = "DiskSpaceUtilization"
	namespace = "System/Detail/Linux"
	period = "120"
	statistic = "Average"
	threshold = "${var.diskspace_critical}"

	alarm_description = "GitHub - critical for low available disk space"
	alarm_actions = ["${aws_sns_topic.sns_github_backup.arn}"]
}