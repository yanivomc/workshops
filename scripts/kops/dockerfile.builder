FROM hashicorp/terraform:0.11.14

ENV KOPS_VERSION=1.15.0
# https://kubernetes.io/docs/tasks/kubectl/install/
# latest stable kubectl: curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV KUBECTL_VERSION=v1.16.3

RUN apk --no-cache add ca-certificates \
  && apk --no-cache add --virtual build-dependencies curl \
  && curl -O --location --silent --show-error https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 \
  && mv kops-linux-amd64 /usr/local/bin/kops \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl \
  && mv kubectl /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kops /usr/local/bin/kubectl \
  && apk del --purge build-dependencies
## Install aws CLI
RUN apk update && \
apk -Uuv add python py-pip && \
pip install awscli && \
apk --purge -v del py-pip && \
rm /var/cache/apk/*

WORKDIR /source
# Prep Kops key source from http://bit.ly/rsa-public
RUN mkdir ~/.ssh/ && \

ADD . ./
wget https://jb-workshop.s3-eu-west-1.amazonaws.com/terraform-provider-aws_v2.39.0_x4 -O .terraform.d/plugin-cache/linux_amd64/terraform-provider-aws_v2.39.0_x4
COPY self-service-k8s-destory.sh self-service-k8s-up.sh /bin/

RUN chmod +x /bin/*.sh && \
cp ./*id* ~/.ssh/
ENV TF_PLUGIN_CACHE_DIR=/source/.terraform.d/plugin-cache

ENTRYPOINT ["./entrypoint.sh"]
CMD ["/bin/ash"]
