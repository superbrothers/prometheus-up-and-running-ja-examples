# 『入門 Prometheus』9章 コンテナとKubernetes サンプルファイル Kubernetes 1.13 対応版

このリポジトリは、オライリー・ジャパン「[入門 Prometheus](https://www.oreilly.co.jp/books/9784873118772/)」の原著である「[Prometheus: Up and Running](http://shop.oreilly.com/product/0636920147343.do)」の「9章　コンテナとKubernetes」で提供されているサンプルファイルを2019年2月時点で最新の Kubernetes 1.13 で動作するように修正したものです。

9章に登場する各ソフトウェアのバージョンは次のとおりです。

| ソフトウェア       | 本書バージョン | 変更後バージョン |
|--------------------|----------------|------------------|
| Minikube           | 0.24.1         | 0.34.1           |
| Kubernetes         | 1.8.0          | 1.13.3           |
| kubectl            | 1.9.2          | 1.13.3           |
| kube-state-metrics | 1.2.0          | 1.5.0            |

## 9.2.1 Kubernetes内でのPrometheusの実行

例9-2 Minikubeのダウンロードと実行
```
hostname $ <b>wget -O minikube https://storage.googleapis.com/minikube/releases/v0.34.1/minikube-$(uname -s | tr "[:upper:]" "[:lower:]")-amd64</b>
hostname $ <b>chmod +x minikube</b>
hostname $ <b>./minikube version</b>
minikube version: v0.34.0
hostname $ <b>./minikube start --kubernetes-version=v1.13.3</b>
o   minikube v0.34.1 on linux (amd64)
>   Creating virtualbox VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
@   Downloading Minikube ISO ...
 184.30 MB / 184.30 MB [============================================] 100.00% 0s
-   "minikube" IP address is 192.168.99.100
-   Configuring Docker as the container runtime ...
-   Preparing Kubernetes environment ...
@   Downloading kubeadm v1.13.3
@   Downloading kubelet v1.13.3
-   Pulling images required by Kubernetes v1.13.3 ...
-   Launching Kubernetes v1.13.3 using kubeadm ... 
-   Configuring cluster permissions ...
-   Verifying component health .....
+   kubectl is now configured to use "minikube"
=   Done! Thank you for using minikube!
```

例9-3 `kubectl`のダウンロードとテスト
```
hostname $ <b>wget https://storage.googleapis.com/kubernetes-release/release/v1.13.3/bin/$(uname -s | tr "[:upper:]" "[:lower:]")/amd64/kubectl</b>
hostname $ <b>chmod +x kubectl</b>
hostname $ <b>./kubectl version</b>
Client Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:08:12Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:00:57Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
hostname $ <b>./kubectl get services</b>
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   2m33s
```

例9-4 パーミッションをセットアップしてKubernetes上でPrometheusを実行する
```
hostname $ git clone git://github.com/superbrothers/prometheus-up-and-running-ja-examples.git
hostname $ ./kubectl apply -f ./prometheus-up-and-running-ja-examples/9/prometheus-deployment.yml
hostname $ ./minikube service prometheus --url
http://192.168.99.100:30114
```

## 9.2.3 kube-state-metrics

例9-11 kube-state-metricsを起動する
```
hostname $ ./kubectl apply -f ./9/kube-state-metrics.yml
hostname $ ./minikube service kube-state-metrics --url
http://192.168.99.100:31774
```

## Kubernetes マニフェストファイル変更内容

本書のサンプルファイルからの変更内容です。

### [prometheus-deployment.yml](./9/prometheus-deployment.yml)

- Kubernetes ClusterRole/ClusterRoleBinding マニフェストを追加
- Kubernetes ConfigMap `prometheus-config` の Prometheus の設定を Kubernetes 1.13 で動作するように修正

### [9-5-prometheus.yml](./9/9-5-prometheus.yml)

- Kubelet メトリクスのスクレイプに Kubernetes Node proxy エンドポイントを利用
- Kubernetes ServiceAccount を利用し認証認可に対応
- Kubernetes API server のサーバ証明書の検証をスキップしないように変更

### [9-6-prometheus.yml](./9/9-6-prometheus.yml)

- Kubelet cAdvisor メトリクスのスクレイプに Kubernetes Node proxy エンドポイントを利用
- Kubernetes ServiceAccount を利用し認証認可に対応
- Kubernetes API server のサーバ証明書の検証をスキップしないように変更

### [9-7-prometheus.yml](./9/9-7-prometheus.yml)

- Kubernetes API server のサーバ証明書の検証をスキップしないように変更

### [9-8-prometheus.yml](./9/9-8-prometheus.yml)

- 変更点なし

### [9-9-prometheus.yml](./9/9-9-prometheus.yml)

- 変更点なし

### [9-10-prometheus.yml](./9/9-10-prometheus.yml)

- 変更点なし

### [kube-state-metrics.yml](./9/kube-state-metrics.yml)

- kube-state-metrics v1.5.0 のコンテナイメージを利用するように変更

## お問い合わせ

サンプルコードに関するお問い合わせは、下記のオライリー・ジャパンのサイトからお願いいたします。

- https://www.oreilly.co.jp/feedback/