from datetime import datetime
import notmuch2
import re
from email.parser import Parser
from bs4 import BeautifulSoup

def process_mail(message):

        html = list(filter(lambda x: x.get_content_type() == 'text/html', message.walk()))

        soup = BeautifulSoup(features="html.parser", markup=html[0].as_string())
        commerce = soup.find(string=re.compile("Comercio")).find_next()
        location = soup.find(string=re.compile("Ciudad")).find_next()
        raw_price = soup.find(string=re.compile("Monto")).find_next().find_next().text
        card = soup.find(string=re.compile(r'VISA|AMEX|MASTER'))
        if card is None:
            card = "unknown"
            card_number = "unknown"
        else:
            card_number= card.find_next().text.replace("\n",'')
            card = card.text.replace("\n",'')


        currency=raw_price[1:4]
        amount = float(raw_price[4:].replace(',', ''))
        print("Comercio: {} ciudad y pais: {}\nTarjet: {}\nMonto: {} {}\n".format(commerce.find_next().text, location.find_next().text , card,amount, currency))
        return {"commerce": commerce.find_next().text.strip("\n").strip("\n"),\
                "location": location.find_next().text.strip("\n").strip("\n"),\
                "amount": amount, "currency": currency, \
                "card_type": card, "card_number": card_number}

def gather_data():
    try:
        db = notmuch2.Database(mode = notmuch2.Database.MODE.READ_WRITE)
        notifications = db.messages("from:notificacion@notificacionesbaccr.com and not tag:ready")
        data = []

        parser = Parser()

        for email in notifications:
            date = email.date

            with open(email.path) as f:
                p = parser.parse(f)
                parsed = process_mail(p)
                parsed["date"]=datetime.strftime(datetime.fromtimestamp(date), "%m/%d/%Y, %H:%M:%S")
                data.append(parsed)

            with email.frozen():
                email.tags.add("ready")

        return data

    except Exception as e:
        raise e
