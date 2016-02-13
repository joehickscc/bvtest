coreo_aws_advisor_iam "advise" do
  action :advise
end

coreo_uni_util_notify "notif-report" do
  action :notify
  type 'email'
  allow_empty true
  send_on "always"
  payload_type "json"
  payload 'STACK::coreo_aws_advisor_iam.advise.report'
  endpoint ({ 
              :to => '${ALERT_EMAIL_ADDRESS}',
              :subject => "CloudCoreo AlertNotification Service (IAM Report)"
            })
end

coreo_uni_util_notify "notif-stats" do
  action :notify
  type 'email'
  allow_empty false
  send_on "always"
  payload_type "json"
  payload <<-EOF
{
   "number_audited": "STACK::coreo_aws_advisor_iam.advise.number_audited",
   "unignored_number_violations": "STACK::coreo_aws_advisor_iam.advise.number_violations",
   "total_number_violations": "STACK::coreo_aws_advisor_iam.advise.number_violations_unfiltered"
}
EOF
  endpoint ({ 
              :to => '${ALERT_EMAIL_ADDRESS}',
              :subject => "CloudCoreo AlertNotification Service (IAM Stats)"
            })
end
