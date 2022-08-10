if ! kubectl get ns zohair-awan; then
    kubectl create ns zohair-awan
fi

if ! kubectl rollout status deployment sample-spring-boot -n zohair-awan; then
    kubectl apply -f kubernetes.yml
fi