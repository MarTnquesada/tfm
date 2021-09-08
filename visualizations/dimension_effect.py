import argparse
import matplotlib.pyplot as plt

COLOR_LOOKUP = {'muse': 'mediumblue', 'vecmap': 'orange','concat': 'mediumseagreen'}
LABEL_LOOKUP = {'muse': 'MUSE', 'vecmap': 'VecMap', 'concat': 'Concatenation'}
LINESTYLE_LOOKUP = {'muse': '-', 'vecmap': '--', 'concat': '-.'}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--results', default={
        'fr':{
            'muse': {50: 29.44, 100: 42.35, 150: 47.59, 200: 50.66, 250: 52.88, 300: 53.35, 400: 54.27, 500: 56.16, 1000: 57.31},
            'vecmap': {50: 33.85, 100: 45.27, 150: 50.22, 200: 53.15, 250: 54.91, 300: 56.20, 400: 57.63, 500: 58.23, 1000: 59.63},
            'concat': {50: 47.71, 100: 47.71, 150: 47.71, 200: 47.71, 250: 47.71, 300: 47.71, 400: 47.71, 500: 47.71, 1000: 47.71}
        },
        'de':{
            'muse': {50: 16.65, 100: 26.25, 150: 30.62, 200: 32.75, 250: 34.42, 300: 36.03, 400: 37.14, 500: 38.06, 1000: 39.20},
            'vecmap': {50: 19.16, 100: 27.68, 150: 31.85, 200: 33.88, 250: 35.69, 300: 36.33, 400: 37.52, 500: 38.77, 1000: 40.13},
            'concat': {50: 53.84, 100: 53.84, 150: 53.84, 200: 53.84, 250: 53.84, 300: 53.84, 400: 53.84, 500: 53.84, 1000: 53.84}
        },
        'ru':{
            'muse': {50: 11.51, 100: 27.20, 150: 34.77, 200: 37.44, 250: 40.18, 300: 40.38, 400: 42.76, 500: 44.34, 1000: 46.02},
            'vecmap': {50: 16.49, 100: 30.32, 150: 37.20, 200: 39.26, 250: 41.25, 300: 44.63, 400: 46.09, 500: 46.21, 1000: 46.91},
            'concat': {50: 0, 100: 0, 150: 0, 200: 0, 250: 0, 300: 0, 400: 0, 500: 0, 1000: 0}
        },
        'hi':{
            'muse': {50: 2.37, 100: 15.28, 150: 19.57, 200: 22.50, 250: 23.34, 300: 25.00, 400: 26.42, 500: 0.08, 1000: 0.09},
            'vecmap': {50: 9.45, 100: 18.40, 150: 22.02, 200: 24.26, 250: 25.80, 300: 26.89, 400: 28.40, 500: 29.17, 1000: 28.87},
            'concat': {50: 0, 100: 0, 150: 0, 200: 0, 250: 0, 300: 0, 400: 0, 500: 0, 1000: 0}
        }
    })

    args = parser.parse_args()


    for lang in ['fr', 'de', 'ru', 'hi']:
        for method in ['muse', 'vecmap', 'concat']:
            results = args.results[lang][method]
            plt.plot([dim for dim in results.keys()],
                     [acc for dim, acc in results.items()],
                     label=LABEL_LOOKUP[method], linestyle=LINESTYLE_LOOKUP[method], color=COLOR_LOOKUP[method],
                     linewidth=3)#marker='o', markersize=5)

        plt.grid()
        plt.setp(plt.gca().get_xticklabels(), fontsize=14)
        plt.setp(plt.gca().get_yticklabels(), fontsize=14)
        plt.gca().set_ylim(top=100, bottom=-2)
        plt.xlabel('Dimension', fontsize=16)
        plt.ylabel('Accuracy', fontsize=16)
        plt.legend(fontsize=16)
        plt.savefig(f'{lang}-en_dimension.pdf')
        plt.clf()



if __name__ == '__main__':
    main()