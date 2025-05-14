# Progetto "Soccorso"


## Premessa

I progetti di fine corso si ispirano sempre ad esigenze reali. La specifica informale del problema data nei paragrafi seguenti può essere, come in ogni caso reale, incompleta e, in alcuni punti, ambigua o contraddittoria. Lo studente dovrà quindi raffinare e disambiguare le specifiche mediante l'interazione con il committente. In alcuni casi allo studente sarà richiesto di valutare diverse possibili alternative, per poi sceglierne una in maniera motivata. Le motivazioni di tutte le scelte interpretative, progettuali e implementative andranno sempre chiaramente documentate nel progetto e verranno discusse in sede di esame.

Nota: alcune delle funzionalità richieste dalla specifica potrebbero non essere realizzabili con singole query, ma richiedere l'uso di strumenti più avanzati messi a disposizione dal DBMS, come le procedure. In ogni caso, tali procedure avrebbero una o più query come parte principale. L'uso di queste caratteristiche avanzate aumenta notevolmente il valore di un progetto. Tuttavia, nel caso si decida di non utilizzarle nell'implementazione, è necessario comunque presentare lo pseudocodice corrispondente, e realizzare completamente le relative query.

## Specifiche

Il database Soccorso rappresenta una generica base di dati per la ricezione e la gestione di richieste di soccorso. La tipologia di soccorso offerto non ci interessa: ci concentreremo solo sul modo generale di realizzare questo tipo di database.

Il database conterrà per prima cosa le informazioni su due categorie di utenza: gli amministratori (che configureranno il sistema, smisteranno le richieste e le monitoreranno) e gli operatori (a cui verranno inviate le richieste e che le gestiranno in prima persona). Gli amministratori potranno creare account per nuovi amministratori ed operatori. Per entrambe le categorie di utenza, oltre ai dati anagrafici, dovrà essere possibile inserire delle informazioni extra quali le patenti possedute (A, B, C, nautica,...) e una lista (generica) di abilità (ad esempio un operatore potrebbe avere un diploma infermieristico, un altro potrebbe essere un elettricista, ecc.) utili per deciderne l'assegnazione alle missioni.

Per effettuare le operazioni di soccorso, gli operatori avranno a disposizione dei mezzi (auto, ambulanze, autopompe... dipende dal tipo di emergenza che verrà gestita effettivamente dal sito) e dei materiali (kit medici, scale, estintori,...). Tali elementi saranno censiti nel database (sempre per essere molto generici, essi avranno solo un nome e una descrizione), e gli amministratori potranno aggiungerli, modificarli o eliminarli.

Le richieste di soccorso immagazzinate nel database dovranno essere necessariamente accompagnate da una breve descrizione, dall'indicazione della posizione (indirizzo, coordinate, ecc.), dal nome e dell'indirizzo email del segnalante, e potranno essere opzionalmente corredate da una foto. Inoltre, per evitare spam e attacchi vari, il sistema dovrà tenere traccia quantomeno dell'indirizzo IP di origine delle richieste. Infine, ogni richiesta inviata, prima di diventare attiva, dovrà essere convalidata. A questo scopo, alla richiesta verrà associata una stringa lunga e casuale che sarà poi usata per costruire un link inviato per email al segnalante. Cliccando tale link, la richiesta verrà marcata come attiva nel database.

Le richieste, in base al loro stato di gestione, potranno essere in stato attivo (inviate e convalidate), in corso (gestite) e chiuso (concluse). Le richieste attive potranno essere ignorate (annullate) o gestite creando una missione. Tale missione avrà associati la richiesta scatenante, un obiettivo, una posizione, una squadra (composta da almeno un operatore caposquadra e da zero o più altri operatori), zero o più mezzi, zero o più materiali, oltre che ovviamente un timestamp di inizio.

Gli amministratori potranno in ogni momento inserire degli aggiornamenti (blocchi di testo descrittivo) in una missione, ciascuno associato con il timestamp di immissione).

Infine, gli amministratori (a seguito di un’opportuna comunicazione da parte degli operatori) potranno marcare una missione come conclusa (chiusa), inserendo data/ora di fine, un generico livello si successo (anche questo dipendente dal tipo di soccorso, possiamo genericamente usare un numero che va da 0=fallimento a 5=successo pieno) e dei commenti opzionali relativi all’intervento eseguito.

Ogni elemento coinvolto nelle missioni (operatori, mezzi, materiali) dovrà essere dotato anche di un proprio storico delle missioni in cui è stato coinvolto.

Ci sono indubbiamente svariati vincoli che possono essere applicati ai contenuti di questa base di dati. L'individuazione dei vincoli e la loro implementazione (con vincoli sulle tabelle, trigger o quantomeno definendo il codice e le query necessari ad effettuarne il controllo) costituiscono un requisito importante per lo sviluppo di un progetto realistico, e ne verrà tenuto conto durante la valutazione finale.
Operazioni da realizzare

Di seguito sono illustrate schematicamente le operazioni previste sulla base di dati, ciascuna da realizzare tramite una query (o, se necessario, tramite più query, opzionalmente racchiuse in una stored procedure). Ovviamente, ogni ulteriore raffinamento o arricchimento di queste specifiche aumenterà il valore del progetto.

    1. Inserimento di una richiesta di soccorso.
    2. Creazione di una missione connessa a una richiesta di soccorso attiva.
    3. Chiusura di una missione.
    4. Estrazione della lista degli operatori non coinvolti in missioni in corso.
    5. Calcolo del numero di missioni svolte da un operatore.
    6. Calcolo del tempo medio di svolgimento delle missioni (dalla creazione alla chiusura) in un anno specifico o per ciascun caposquadra.
    7. Calcolo del numero di richieste provenienti da un certo soggetto segnalante (identificato dall'indirizzo email) o da un certo indirizzo IP nelle ultime 36 ore.
    8. Calcolo del tempo totale di impiego in missione di un certo operatore (cioè somma delle durata delle missioni in cui è stato coinvolto)
    10. Estrazione delle missioni svoltesi negli ultimi tre anni nello stesso luogo di una missione data.
    11. Estrazione della lista delle richieste di soccorso chiuse con risultato non totalmente positivo (livello di successo minore di 5).
    12. Estrazione degli operatori maggiormente coinvolti nelle richieste di soccorso chiuse con risultato non totalmente positivo (calcolate come alla query precedente).
    13. Estrazione dello storico delle missioni in cui è stato coinvolto un certo mezzo.
    14. Calcolo delle ore d'uso di un certo materiale (supponiamo che il tempo d'uso uso corrisponda alla durata totale della missione in cui è stato assegnato).

È possibile inserire procedure di gestione addizionali che si ritengano utili.