# Gioele



## Descrizione generale

Questo è il progetto relativo al mio tirocinio svolto in ambito Dev-Sec-Ops per la creazione di un'infrastruttura per automatizzare il rilascio di un'applicazione a microservizi su un ambiente cloud.

![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/ff54add3-14fc-484e-beec-9f72b33b54d7)


## Tecnologie utilizzate

Le tecnologie utilizzate in questo progetto sono svariate:
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
- Checkmarx per i controlli statici e dinamici sul codice
- Terrascan per rilevare le conformità e le violazioni della sicurezza in tutta l'infrastruttura come codice

Come piattaforma cloud ho utilizzato Azure.

![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/36e1a394-5995-402a-9a6b-edc5e682064a)


Come si può notare dal diagramma la struttura della pipeline di rilascio è molto semplice:
- viene prelevato il codice Terraform dalla repository, viene valutato, controllato tramite terrascan e se passa il quality gate viene rilasciata l'infrastruttura su Azure

## Pipeline
![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/47c265dc-5a64-41cd-ab0f-e28524cf2a57)

## Sicurezza IAC

Questo è il risultato formattato della scansione con Trivy
![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/be516d31-113f-4cc4-a7a5-e179b291424f)

Questo è un estratto della scansione con Nmap, per semplicità non riporterò tutto l'output
![image](https://github.com/lele2702/DevSecOps-stage-project/assets/85575751/1864ac24-fe19-431d-97a9-53dd9dfc26a1)

In base al rapporto di scansione Nmap fornito, si possono osservare le seguenti informazioni:

L'host scansionato con l'indirizzo IP 52.166.129.78 è attivo e risponde, con una latenza di 0,32 secondi.

Viene mostrata solo una porta aperta: la porta 22, associata al servizio SSH (Secure Shell).

Il servizio SSH in esecuzione sulla porta 22 viene identificato come OpenSSH 7.4 e utilizza la versione del protocollo 2.0.

È STATA eseguitA ANCHE una scansione di vulnerabilità aggiuntiva utilizzando i database VulDB, MITRE CVE, SecurityFocus, IBM X-Force e Exploit-DB.

I risultati della scansione delle vulnerabilità indicano varie vulnerabilità associate a OpenSSH, tra cui vulnerabilità di denial-of-service, vulnerabilità di bypass della sicurezza, vulnerabilità di esecuzione remota di codice, vulnerabilità di divulgazione delle informazioni, vulnerabilità di escalation dei privilegi e altre. Ogni vulnerabilità è identificata dal suo numero CVE (Common Vulnerabilities and Exposures).


