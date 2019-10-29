from setuptools import setup, find_packages
import os
os.environ['KMP_DUPLICATE_LIB_OK'] = 'True'

here = os.path.abspath(os.path.dirname(__file__))

# Avoids IDE errors, but actual version is read from version.py
__version__ = None
with open("rasa/version.py") as f:
    exec(f.read())

# Get the long description from the README file
with open(os.path.join(here, "README.md"), encoding="utf-8") as f:
    long_description = f.read()

install_requires = [
    "spacy>=0.0.4",
    "scikit-learn>=0.20.0",
    "spacy-transformers>=0.5.1"
]

setup(
    name="rasa",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        # supported python versions
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Topic :: Software Development :: Libraries",
    ],
    python_requires=">=3.6",
    packages=find_packages(exclude=["tests", "tools", "docs", "contrib"]),
    entry_points={"console_scripts": ["rasa=rasa.__main__:main"]},
    version=__version__,
    install_requires=install_requires,
    include_package_data=True,
    description="Open source machine learning framework to automate text- and "
    "voice-based conversations: NLU, dialogue management, connect to "
    "Slack, Facebook, and more - Create chatbots and voice assistants",
    long_description=long_description,
    long_description_content_type="text/markdown",
    author="Rasa Technologies GmbH",
    author_email="hi@rasa.com",
    maintainer="Tom Bocklisch",
    maintainer_email="tom@rasa.com",
    license="Apache 2.0",
    keywords="nlp machine-learning machine-learning-library bot bots "
    "botkit rasa conversational-agents conversational-ai chatbot"
    "chatbot-framework bot-framework",
    url="https://rasa.com",
    download_url="https://github.com/RasaHQ/rasa/archive/{}.tar.gz"
    "".format(__version__),
    project_urls={
        "Bug Reports": "https://github.com/rasahq/rasa/issues",
        "Source": "https://github.com/rasahq/rasa",
    },
)

print("\nWelcome to Rasa!")
print(
    "If you have any questions, please visit our documentation page: https://rasa.com/docs/"
)
print("or join the community discussions on https://forum.rasa.com/")
