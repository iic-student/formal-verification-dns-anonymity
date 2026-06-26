These verification models formally verify sender anonymity and DNS query anonymity using the observational equivalence feature of Tamarin Prover.

Docker must be installed in advance.

- Docker (Docker Desktop etc...)

1. Settings ⇒ General ⇒ ☑ Use the WSL 2 based engine
2. Settings ⇒ Resources ⇒ ☑ Enable Resource Saver ⇒ Apply

## Reproduction Procedure 
Using Docker allows you to reproduce verification without setting up an environment.


1. Building Docker Images 
```bash
docker build -t dns-thesis .
```
2. Execute all verifications 
```bash
docker run --rm \
    -v "$(pwd)/proof_results:/thesis/proof_results" \
    dns-thesis
```
3. Review the list of results 
```bash
ls proof_results
```
4. Verify only specific files 
```bash
docker run --rm -it \
    --entrypoint tamarin-prover \
    dns-thesis \
    --diff models/[file_name].spthy --prove
```
5. Verify in interactive mode 
```bash
docker run --rm -it \
    -p 3001:3001 \
    -v "$(pwd):/thesis" \
    --entrypoint tamarin-prover \
    dns-thesis \
    interactive models/[file_name].spthy \
    --diff --interface=0.0.0.0 --port=3001
```
## Model List
The following describes the main models (.spthy) included in this repository.


### Direct Communication
| File | Adversary Location | Verified Property |
| :--- | :--- | :--- |
| `ECH_FR.spthy` | Passive adversary on the communication path | Sender anonymity |
| `ECH_Query.spthy` | Passive adversary on the communication path | DNS query anonymity |
| `ECHAuth_FR.spthy` | Passive adversary inside the authoritative server | Sender anonymity |
| `ECHAuth_Query.spthy` | Passive adversary inside the authoritative server | DNS query anonymity |


### Multi-Relay Communication
| File | Adversary Location | Verified Property |
| :--- | :--- | :--- |
| `ProxyTargetAuth_FR.spthy` | Passive adversary on the communication path | Sender anonymity |
| `ProxyTargetAuth_Query.spthy` | Passive adversary on the communication path | DNS query anonymity |
| `ProxyTargetConspiracy_FR.spthy` | Passive adversary inside the authoritative DNS server | Sender anonymity |
| `ProxyTargetConspiracy_Query.spthy` | Passive adversary inside the authoritative DNS server | DNS query anonymity |
| `ProxyTargetProxy_FR.spthy` | Collusion between the proxy and the authoritative DNS server | Sender anonymity |
| `ProxyTargetProxy_Query.spthy` | Collusion between the proxy and the authoritative DNS server | DNS query anonymity |
| `ProxyTargetTarget_FR.spthy` | Passive adversary inside the proxy | Sender anonymity |
| `ProxyTargetTarget_Query.spthy` | Passive adversary inside the proxy | DNS query anonymity |
