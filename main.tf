variable "default_threshold" {
  description = "The default threshold for the metric."
  default     = 5
}

variable "default_evaluation_periods" {
  description = "The default amount of evaluation periods."
  default     = 2
}

variable "default_datapoints_to_alarm" {
  description = "The default amount of datapoints to alarm."
  default     = 2
}

variable "default_period" {
  description = "The default evaluation period."
  default     = 60
}

variable "default_comparison_operator" {
  description = "The default comparison operator."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "default_statistic" {
  description = "The default statistic."
  default     = "Average"
}

variable "default_actions_enabled" {
  description = "Indicates whether or not actions should be executed during any changes to the alarm's state."
  default     = true
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  count = length(var.alarms)

  alarm_name = format("%s-%s-%s",
    var.domain,
    var.distribution_id,
    element(keys(var.alarms), count.index)
  )

  comparison_operator = lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "comparison_operator",
    var.default_comparison_operator
  )

  evaluation_periods = lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "evaluation_periods",
    var.default_evaluation_periods
  )

  datapoints_to_alarm = lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "datapoints_to_alarm",
    var.default_datapoints_to_alarm
  )

  metric_name = element(keys(var.alarms), count.index)

  namespace   = "AWS/CloudFront"

  period = lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "period",
    var.default_period
  )

  statistic = lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "statistic",
    var.default_statistic
  )

  threshold = lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "threshold",
    var.default_threshold
  )

  dimensions = {
    DistributionId = var.distribution_id
    Region         = "Global"
  }

  alarm_actions = compact(split(",", lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "actions",
    ""
  )))

  actions_enabled = compact(split(",", lookup(
    var.alarms[element(keys(var.alarms), count.index)],
    "actions_enabled",
    var.default_actions_enabled
  )))
}
