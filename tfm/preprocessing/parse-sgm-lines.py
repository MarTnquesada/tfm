import argparse
from typing import Dict
from bs4 import BeautifulSoup


def get_document_lookup(filepath) -> Dict:
    with open(filepath, 'r') as f:
        data= f.read()
        soup = BeautifulSoup(data, features='lxml')
        documents = soup.findAll('doc')
        lookup = {}
        for doc in documents:
            lookup[doc.attrs.get('docid')] = doc.text
        return lookup


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--ifile1')
    parser.add_argument('--ifile2')
    parser.add_argument('--ofile1')
    parser.add_argument('--ofile2')
    args = parser.parse_args()

    lookup1 = get_document_lookup(args.ifile1)
    lookup2 = get_document_lookup(args.ifile2)

    common_docids = set(lookup1.keys()).intersection(lookup2.keys())
    common_docids = sorted(common_docids)
    with open(args.ofile1, 'w') as of1:
        with open(args.ofile2, 'w') as of2:
            for docid in common_docids:
                of1.write(lookup1[docid].lstrip())
                of2.write(lookup2[docid].lstrip())


if __name__ == '__main__':
    main()
