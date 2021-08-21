import argparse
import matplotlib.pyplot as plt

COLOR_LOOKUP = {'fr-en': 'mediumblue', 'de-en': 'gold', 'ru-en': 'red','hi-en': 'forestgreen'}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--results', default={'fr-en': {50: 33.85, 100: 45.27, 150: 50.22, 200: 53.15, 250:54.91, 300: 56.20},
                                              'de-en': {50: 19.16, 100: 0, 150: 31.85, 200: 33.88, 250:35.69, 300: 36.33},
                                              'ru-en': {50: 0, 100: 0, 150: 37.20, 200: 39.26, 250: 41.25, 300: 44.63},
                                              'hi-en': {50: 0, 100: 0, 150: 22.02, 200: 24.26, 250: 25.80, 300: 26.89}
                                              })
    args = parser.parse_args()

    for lang, dimension_results in args.results.items():
        plt.plot([dim for dim in dimension_results.keys()],
                 [acc for dim, acc in dimension_results.items()],
                 color=COLOR_LOOKUP[lang], marker='o', )# linewidth=5, markersize=5)
    plt.show()


if __name__ == '__main__':
    main()