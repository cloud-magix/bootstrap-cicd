
REGION := $(or ${AWS_REGION}, "us-east-1")
STACK_NAME := $(or ${STACK_NAME}, "bootstrap-external-access-stack")
SOURCE_IDENTITIES := $(or ${SOURCE_IDENTITIES}, )
EXTERNAL_ID := $(or ${EXTERNAL_ID}, )
SECRET_ARN := $(or ${SECRET_ARN}, )
deploy:
ifndef EXTERNAL_USER_NAME
	$(error EXTERNAL_USER_NAME required)
endif
ifndef PRIVILEDGED_ROLE_NAME
	$(error PRIVILEDGED_ROLE_NAME required)
endif
	aws --region $(REGION) cloudformation deploy --stack-name  $(STACK_NAME)\
		--template-file cloudformation.yaml --capabilities CAPABILITY_NAMED_IAM --force-upload --no-fail-on-empty-changeset \
		--parameter-overrides ExternalIdentityUserName=$(EXTERNAL_USER_NAME) PrivilegedRoleName=$(PRIVILEGED_ROLE_NAME) \
		SourceIdentities=$(SOURCE_IDENTITIES) ExternalId=$(EXTERNAL_ID) SecretArn=$(SECRET_ARN)