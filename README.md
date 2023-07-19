# Gioele



## Descrizione generale

Questo è il progetto relativo al mio tirocinio svolto in ambito Dev-Sec-Ops per la creazione di un'infrastruttura per automatizzare il rilascio di un'applicazione a microservizi su un ambiente cloud.

![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/469aa09a-323b-4441-88c7-11e01988dd73)



## Tecnologie utilizzate

Le tecnologie utilizzate durante lo sviluppo sono svariate:
- VMware e virtualbox per la creazione delle vm in locale
- sistema operativo di tutte le virtual machine CentOs 7
- GitLab per la repository relativa all'IAC
- GitHub per la repository relativa all'applicazione da rilasciare
- Docker per la creazione di immagini e container
- Kubernetes per automatizzare le operazioni dei container Linux, eliminando molti dei processi manuali coinvolti nel deployment
- Terraform per la creazione dell'infrastruttura
- Jenkins per l'automazione
- Trivy per l’analisi sui file Docker e sulle immagini che compongono l’applicazione
- Nmap per il vulnerability assessment dell'infrastruttura
- Sonarqube per i controlli statici e OWASP ZAP per i controlli dinamici sul codice
- Terrascan per rilevare le conformità e le violazioni della sicurezza in tutta l'infrastruttura come codice


## Pipeline IAC
![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/a152c709-bf2b-4cfa-bb4d-df828bc86a38)

Come piattaforma cloud ho utilizzato Azure.

Come si può notare dal diagramma la struttura della pipeline di rilascio è molto semplice:
- viene prelevato il codice Terraform dalla repository, viene valutato, controllato tramite terrascan e se passa il quality gate viene rilasciata l'infrastruttura su Azure

## Sicurezza IAC

Questo è il risultato formattato della scansione con Trivy
![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/2523bf63-bccc-4300-bc83-068f359b6c42)


Questo è un estratto della scansione con Nmap, per semplicità non riporterò tutto l'output

![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/6caae141-83f9-42ea-bda9-b10480696359)

In base al rapporto di scansione Nmap fornito, si possono osservare le seguenti informazioni:

L'host scansionato con l'indirizzo IP 52.166.129.78 è attivo e risponde, con una latenza di 0,32 secondi.

Viene mostrata solo una porta aperta: la porta 22, associata al servizio SSH (Secure Shell).

Il servizio SSH in esecuzione sulla porta 22 viene identificato come OpenSSH 7.4 e utilizza la versione del protocollo 2.0.

È STATA eseguitA ANCHE una scansione di vulnerabilità aggiuntiva utilizzando i database VulDB, MITRE CVE, SecurityFocus, IBM X-Force e Exploit-DB.

I risultati della scansione delle vulnerabilità indicano varie vulnerabilità associate a OpenSSH, tra cui vulnerabilità di denial-of-service, vulnerabilità di bypass della sicurezza, vulnerabilità di esecuzione remota di codice, vulnerabilità di divulgazione delle informazioni, vulnerabilità di escalation dei privilegi e altre. Ogni vulnerabilità è identificata dal suo numero CVE (Common Vulnerabilities and Exposures).


## Monitoring IAC

![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/568de994-d103-46f6-9ab6-e8f79984d8bf)

![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/311c5467-e28a-40f3-aa8b-988fbcd7943e)

Come si può vedere dall'immagine precedente per il monitoring ho deciso di fare la deploy di Prometheus e Grafana sul cluster in un namespace separato.



