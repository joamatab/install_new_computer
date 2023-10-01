
create:
	eksctl create cluster -f cluster.yaml

delete:
	eksctl delete cluster --region=us-west-2 --name=cluster-in-existing-vpc

new:
	eksctl create cluster --name eks --nodes 4 --region us-west-2

update:
	eksctl update cluster -f cluster.yaml
