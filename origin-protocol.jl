helm upgrade $(cat .namespace) devops/kubernetes/charts/origin \
          -f devops/kubernetes/charts/origin/values.yaml \
          -f devops/kubernetes/values/origin/values-$(cat .namespace).yaml \
          -f devops/kubernetes/values/origin/secrets-$(cat .namespace).yaml
timeout: '3600s'
options:
  machineType: 'N1_HIGHCPU_32'
'3600s'

options:

  machineType: 'N1_HIGHCPU_32
