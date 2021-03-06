# RELEASE="$(curl -sSL https://dl.k8s.io/release/stable.txt)"
RELEASE="v1.12.5"

BIN_DIR="/usr/local/bin"
mkdir -p "${BIN_DIR}"
cd "${BIN_DIR}" || exit 1

curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${RELEASE}/bin/linux/amd64/{kubeadm,kubelet,kubectl}
chmod +x {kubeadm,kubelet,kubectl}

curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/${RELEASE}/build/debs/kubelet.service" | sed "s:/usr/bin:${BIN_DIR}:g" > /etc/systemd/system/kubelet.service
mkdir -p /etc/systemd/system/kubelet.service.d
curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/${RELEASE}/build/debs/10-kubeadm.conf" | sed "s:/usr/bin:${BIN_DIR}:g" > /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
